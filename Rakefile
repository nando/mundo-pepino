# build stuff
require(File.join(File.dirname(__FILE__), 'features', 'support', 'app', 'config', 'boot'))
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

unless ARGV.any? {|a| a =~ /^gems/}
  begin
    require 'cucumber/rake/task'
    namespace :mundo_pepino do
      Cucumber::Rake::Task.new({:es_ES => 'db:test:prepare'}) do |t|
        t.cucumber_opts = "--require features/support/env.rb --require features/step_definitions/mundo_pepino_es_ES.rb --format progress --language es features/es_ES"
      end
  
      desc 'Run all MundoPepino features on every supported language'
      task :all => [:es_ES]
    end
  
    task :default => 'mundo_pepino:es_ES'

  rescue LoadError
    desc 'cucumber rake task not available (cucumber not installed)'
    task :cucumber do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end
end

# gem stuff
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
    ['cucumber', '>=0.3.102'],
    ['webrat', '>=0.5.3'],
    ['rspec', '>=1.2.6'],
    ['rspec-rails', '>=1.2.6'],
    ['string-mapper','>= 0.1.0']
  ]
end

