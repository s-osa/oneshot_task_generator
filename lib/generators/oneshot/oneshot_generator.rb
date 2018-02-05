require 'oneshot_generator/version'

class OneshotGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_reader :current, :timestamp, :task_name

  def setup
    @current   = Time.current
    @timestamp = @current.strftime('%Y%m%d')
    @task_name = "#{name.underscore}_#{timestamp}"
  end

  def create_file_with_template
    template 'oneshot.rake.erb', "lib/tasks/oneshot/#{timestamp}_#{name.underscore}.rake"
  end
end
