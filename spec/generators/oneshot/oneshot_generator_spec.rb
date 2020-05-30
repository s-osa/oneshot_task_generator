require 'generators/oneshot/oneshot_generator'

RSpec.describe OneshotGenerator, type: :generator do
  destination_path = File.expand_path('../../../../tmp', __FILE__)

  destination destination_path

  let(:args) { ['FooBar'] }

  around do |example|
    prepare_destination
    example.run
    FileUtils.rm_rf(destination_path)
  end

  describe 'method call' do
    it 'run all tasks in the generator' do
      gen = generator(args)
      expect(gen).to receive(:setup)
      expect(gen).to receive(:create_file_with_template)
      gen.invoke_all
    end
  end

  describe 'file generation' do
    before do
      run_generator(args)
    end

    it 'generate a file in lib/tasks/oneshot/' do
      files = Dir.glob("tmp/lib/tasks/oneshot/*")
      expect(files.size).to eq 1
    end

    it 'generate a file with specific file name' do
      file_name = File.basename(Dir.glob("tmp/lib/tasks/oneshot/*").first)
      expect(file_name).to match(/\d{8}_foo_bar.rake/)
    end

    it 'is valid as ruby' do
      file_name = Dir.glob("tmp/lib/tasks/oneshot/*").first
      generated_text = File.read(file_name)
      expect(generated_text).to be_valid_as_ruby
    end
  end

  describe 'configuration' do
    describe 'body' do
      around(:each) do |example|
        described_class.config.body = <<-BODY
ActiveRecord::Base.transaction do
  # Write transactional code here

  # blah
end
        BODY
        example.run
        described_class.config = nil
      end

      before do
        run_generator(args)
      end

      it 'inserts body' do
        file_name = Dir.glob("tmp/lib/tasks/oneshot/*").first
        generated_text = File.read(file_name)
        # expected_body has 4 spaces indentation
        expected_body = <<-BODY
    ActiveRecord::Base.transaction do
      # Write transactional code here

      # blah
    end
        BODY
        expect(generated_text).to include(expected_body)
      end

      it 'is valid as ruby' do
        file_name = Dir.glob("tmp/lib/tasks/oneshot/*").first
        generated_text = File.read(file_name)
        expect(generated_text).to be_valid_as_ruby
      end
    end

    describe 'arguments' do
      around(:each) do |example|
        described_class.config.arguments = ['task', 'args']
        example.run
        described_class.config = nil
      end

      before do
        run_generator(args)
      end

      it 'inserts the arguments' do
        file_name = Dir.glob("tmp/lib/tasks/oneshot/*").first
        generated_text = File.read(file_name)
        expect(generated_text).to match(/^  task '\d{8}_foo_bar': :environment do \|task, args\|$/)
      end

      it 'is valid as ruby' do
        file_name = Dir.glob("tmp/lib/tasks/oneshot/*").first
        generated_text = File.read(file_name)
        expect(generated_text).to be_valid_as_ruby
      end
    end

    describe 'directory' do
      let(:directory) { 'my/favorite/directory' }

      around(:each) do |example|
        described_class.config.directory = directory
        example.run
        described_class.config = nil
      end

      before do
        run_generator(args)
      end

      it 'generates a file in specified directory' do
        expect(Dir.glob("tmp/#{directory}/*").size).to eq(1)
      end
    end
  end
end
