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
