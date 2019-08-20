class OneshotGenerator < Rails::Generators::NamedBase
  class Configuration
    attr_accessor :body, :arguments
  end
end

