# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{has_setting}
  s.version = "0.3.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Simplificator GmbH"]
  s.date = %q{2009-02-07}
  s.description = %q{Stores settings as key/value pairs in a settings table and provides accessors for them on the owning object}
  s.email = %q{info@simplificator.com}
  s.files = ["VERSION.yml", "lib/has_setting", "lib/has_setting/ar_extensions.rb", "lib/has_setting/formatters.rb", "lib/has_setting/setting.rb", "lib/has_setting.rb", "test/bar.rb", "test/baz.rb", "test/foo.rb", "test/test_helper.rb", "test/unit", "test/unit/formatters_test.rb", "test/unit/has_setting_test.rb", "test/unit/test.sqlite3"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pascalbetz/has_setting}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{simple setting extension to AR}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
