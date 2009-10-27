# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{string-mapper}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Fernando Garc\303\255a Samblas"]
  s.date = %q{2009-10-27}
  s.description = %q{}
  s.email = ["fernando.garcia@the-cocktail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt"]
  s.files = ["COPYING", "History.txt", "Manifest.txt", "README.markdown", "Rakefile", "init.rb", "lib/string-mapper.rb", "spec/string-mapper_spec.rb", "string-mapper.gemspec"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{string-mapper}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{String extension for conversions based on dynamic mappings}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 1.2.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<activesupport>, [">= 1.2.0"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 1.2.0"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
