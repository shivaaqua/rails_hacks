# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rails_hacks/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["shivashankar"]
  gem.email         = ["shivashankar.it@gmail.com"]
  gem.description   = %q{Customized rails hacks}
  gem.summary       = %q{Rails hacks related to exception, custom tag builder}
  gem.homepage      = "https://github.com/shivaaqua/rails_hacks"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rails_hacks"
  gem.require_paths = ["lib"]
  gem.version       = RailsHacks::VERSION
  gem.platform      = Gem::Platform::RUBY
end
