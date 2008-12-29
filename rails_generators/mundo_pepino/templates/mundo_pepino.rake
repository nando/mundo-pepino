$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:caracteristicas) do |t|
  t.cucumber_opts = "--format pretty --language es caracteristicas"
end
task :caracteristicas => 'db:test:prepare'
