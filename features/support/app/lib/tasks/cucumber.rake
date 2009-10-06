$LOAD_PATH.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib') if File.directory?(RAILS_ROOT + '/vendor/plugins/cucumber/lib')

unless ARGV.any? {|a| a =~ /^gems/}

begin
  require 'cucumber/rake/task'
  namespace :mundo_pepino do
    Cucumber::Rake::Task.new({:es_ES => 'db:test:prepare'}) do |t|
      t.cucumber_opts = "--require ../env.rb --require ../../step_definitions/mundo_pepino_es_ES.rb --format progress --language es ../../../features/es_ES"
    end

    desc 'Run all MundoPepino features on every supported language'
    task :all => [:es_ES]
  end
  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :default => :cucumber

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end

end
