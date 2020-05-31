require 'generators/oneshot/oneshot_generator/configurator'

class OneshotGenerator < Rails::Generators::NamedBase
  extend Configurator

  source_root File.expand_path('../templates', __FILE__)

  attr_reader :current, :timestamp, :task_name, :configuration

  def setup
    @current   = Time.current
    @timestamp = @current.strftime('%Y%m%d')
    @task_name = "#{timestamp}_#{name.underscore}"
    @configuration = self.class.configuration
  end

  def create_file_with_template
    path = File.join(@configuration.directory, "#{task_name}.rake")
    template 'oneshot.rake.erb', path
  end
end
