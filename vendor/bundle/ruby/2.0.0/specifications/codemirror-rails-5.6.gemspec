# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "codemirror-rails"
  s.version = "5.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nathan Fixler"]
  s.date = "2015-08-22"
  s.description = "This gem provides CodeMirror assets for your Rails application."
  s.email = "nathan@fixler.org"
  s.homepage = "https://rubygems.org/gems/codemirror-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14"
  s.summary = "Use CodeMirror with Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["< 5", ">= 3.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<railties>, ["< 5", ">= 3.0"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<railties>, ["< 5", ">= 3.0"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end
