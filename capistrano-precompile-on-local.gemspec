# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/precompile_on_local/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-precompile-on-local'
  spec.version       = Capistrano::PrecompileOnLocal::VERSION
  spec.authors       = ['ayaya']
  spec.email         = ['ayaya@ayaya.tw']
  spec.summary       = %q(Precompile assets on local machine and upload them to the server.)
  spec.description   = %q(Precompile assets on local machine and upload them to the server.)
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.0'
  spec.add_dependency 'capistrano-rails'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
end
