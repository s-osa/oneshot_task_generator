class OneshotGenerator < Rails::Generators::NamedBase
  class Configuration
    attr_accessor :body

    def initialize
      @body = nil
    end
  end
end

