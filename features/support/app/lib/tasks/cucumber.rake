$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
require 'cucumber/rake/task'

namespace :mundo_pepino do
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "--require ../env.rb --format progress --language es ../../../features"
  end
  task :features => 'db:test:prepare'
end  
