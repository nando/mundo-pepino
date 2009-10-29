When /^I invoke "(.*)" generator with arguments "(.*)"$/ do |generator, arguments|
  @stdout = StringIO.new
  in_project_folder do
    if Object.const_defined?("APP_ROOT")
      APP_ROOT.replace(FileUtils.pwd)
    else 
      APP_ROOT = FileUtils.pwd
    end
    run_generator(generator, arguments.split(' '), SOURCES, :stdout => @stdout)
  end
  File.open(File.join(@tmp_root, "generator.out"), "w") do |f|
    @stdout.rewind
    f << @stdout.read
  end
end

When /^I run executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "#{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

When /^I invoke task "rake (.*)"/ do |task|
  @stdout = File.expand_path(File.join(@tmp_root, "rake.out"))
  @stderr = File.expand_path(File.join(@tmp_root, "rake.err"))
  in_project_folder do
    system "rake #{task} --trace > #{@stdout} 2> #{@stderr}"
  end
end

Then /^I should see '([^\']*)'$/ do |text|
  actual_output = File.read(@stdout)
  actual_output.should contain(text)
end

Given /^a Rails app$/ do
  FileUtils.chdir(@tmp_root) do
    `rails my_project`
  end
  @active_project_folder = File.expand_path(File.join(@tmp_root, "my_project"))
end

Given /^I copy the project generators into "([^\"]*)"$/ do |target_folder|
  in_project_folder do
    FileUtils.mkdir_p(target_folder)
  end
  `cp -rf #{File.dirname(__FILE__) + "/../../rails_generators/*"} #{File.join(@active_project_folder, target_folder)}`
end
