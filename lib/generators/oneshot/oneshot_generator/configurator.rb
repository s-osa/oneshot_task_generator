require 'generators/oneshot/oneshot_generator/configuration'

class OneshotGenerator < Rails::Generators::NamedBase
  module Configurator
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

    def configuration=(config)
      @configuration = config
    end
    alias :config= :configuration=
  end
end
