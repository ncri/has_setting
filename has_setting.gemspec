# -*- encoding: utf-8 -*-

require File.expand_path('../lib/has_setting/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Simplificator GmbH", "Nico Ritsche"]
  gem.email         = ['info@simplificator.com', "ncrdevmail@gmail.com"]
  gem.description   = %q{Stores settings as key/value pairs in a settings table and provides accessors for them on the owning object}
  gem.summary       = %q{Simple setting extension to AR}
  gem.homepage      = "http://github.com/ncri/has_setting"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "has_setting"
  gem.require_paths = ["lib"]
  gem.version       = HasSetting::VERSION
  gem.has_rdoc      = true
  gem.rdoc_options  = ["--charset=UTF-8"]
  gem.test_files    = [
    "test/bar.rb",
    "test/baz.rb",
    "test/foo.rb",
    "test/test_helper.rb",
    "test/unit/formatters_test.rb",
    "test/unit/has_setting_test.rb"
  ]

end
