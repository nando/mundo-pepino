$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
gem 'cucumber', '> 0.3.101', '<= 0.4.4'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:caracteristicas) do |t|
  t.cucumber_opts = "--format pretty --language es features"
end
task :caracteristicas => 'db:test:prepare'
