lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oneshot_task_generator/version'

Gem::Specification.new do |spec|
  spec.name          = 'oneshot_task_generator'
  spec.version       = OneshotTaskGenerator::VERSION
  spec.authors       = ['OSA Shunsuke']
  spec.email         = ['hhelibebcnofnenamg@gmail.com']

  spec.summary       = %q{Generator for oneshot rake task}
  spec.homepage      = 'https://github.com/s-osa/oneshot_task_generator'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rails', '>= 3.0.0'

  spec.add_development_dependency 'ammeter'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'sqlite3'
end
