class OneshotGenerator < Rails::Generators::NamedBase
  class Configuration
    DEFAULT_DIRECTORY = 'lib/tasks/oneshot'.freeze

    attr_accessor :body, :arguments

    def directory
      @directory || DEFAULT_DIRECTORY
    end

    def directory=(dir)
      @directory = dir
    end
  end
end

