require 'generators/oneshot/oneshot_generator'

RSpec.describe OneshotGenerator, type: :generator do
  destination_path = File.expand_path('../../../../tmp', __FILE__)

  destination destination_path

  let(:args) { ['FooBar'] }

  before do
    prepare_destination
  end

  after do
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
  end
end
