# -*- encoding: utf-8 -*-
require 'rake'

Gem::Specification.new do |s|
  s.name = %q{string-mapper}
  s.version = "0.1.0"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fernando García Samblas"]
  s.autorequire = %q{string-mapper}
  s.date = %q{2009-09-30}
  s.email = %q{fernando.garcia@the-cocktail.com}
  s.files = ["History.txt", "COPYING", "README.markdown", "Rakefile", "lib/string-mapper.rb", "spec/string-mapper_spec.rb"]
  s.homepage = %q{http://github.com/nando/string-mapper}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{String extension for conversions based on dynamic mappings}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<activesupport>, [">= 1.2.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 1.2.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 1.2.0"])
  end
end
