# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monitor_baby/version'

Gem::Specification.new do |spec|
  spec.name          = 'monitor_baby'
  spec.version       = MonitorBaby::VERSION
  spec.authors       = ['Dave McNulla']
  spec.email         = ['mcnulla@gmail.com']
  spec.description   = 'Server monitor'
  spec.summary       = 'Small monitor service for testing servers status'
  spec.homepage      = 'https://github.com/dmcnulla/monitor_baby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'net-ssh-telnet'
  spec.add_dependency 'net-ping'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'cucumber', '~> 1.3', '>= 1.3.5'
  spec.add_development_dependency 'fig_newton', '~> 0.9'
  spec.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  spec.add_development_dependency 'webmock', '~> 1.13', '>= 1.13.0'
  spec.add_development_dependency 'rubocop'
end
