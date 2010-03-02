# build stuff
require(File.join(File.dirname(__FILE__), 'features', 'support', 'app', 'config', 'boot'))
require 'rake'

# Commented to avoid that runcoderun uses "test" as default task
# require 'rake/testtask'
# require 'rake/rdoctask'
# require 'tasks/rails'

unless ARGV.any? {|a| a =~ /^gems/}
  begin
    gem 'cucumber', '> 0.3.101', '<= 0.5.0'
    require 'cucumber/rake/task'
    namespace :mundo_pepino do
      build_tasks = [:lib, :rails_generators, :en_US, :es_ES, :capybara_en_US, :capybara_es_ES]
      build_tasks.each do |lang|
        Cucumber::Rake::Task.new(lang) do |t|
          t.cucumber_opts = "--profile #{lang} --format pretty"
        end
      end
  
      desc 'Run all MundoPepino features on every supported language'
      task :all => build_tasks
    end
    task :default => :'mundo_pepino:all'

  rescue LoadError
    desc 'cucumber rake task not available (cucumber not installed)'
    task :cucumber do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end
end

# gem stuff
if ENV['BUILDING_NEWGEM']
  require 'rubygems'
  gem 'hoe', '>= 2.1.0'
  require 'hoe'
  require 'fileutils'
  require 'newgem/tasks'
  require 'lib/mundo_pepino/version'
  
  Hoe.plugin :newgem
  
  $hoe = Hoe.spec 'mundo-pepino' do
    self.summary = 'MundoPepino is a set of reusable step definitions to test Rails apps with Cucumber'
    self.url = 'http://github.com/nando/mundo-pepino'
    self.version = MundoPepino::VERSION::STRING
    self.developer 'Fernando García Samblas', 'fernando.garcia@the-cocktail.com'
    self.rubyforge_name = self.name # TODO this is default value
    self.extra_deps = [
      ['rails', '>=2.0.0'],
      ['cucumber', '<= 0.5.0'],
      ['cucumber-rails', '<= 0.2.0'],
      ['webrat', '>=0.5.3'],
      ['rspec', '>=1.2.6'],
      ['rspec-rails', '>=1.2.6'],
      ['nokogiri', '>= 1.2.0'],
      ['string-mapper','>= 0.1.2.1']
    ]
  end
end
