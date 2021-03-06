Given /^a Rails app$/ do
  FileUtils.chdir(@tmp_root) do
    `rails my_project`
  end
  @active_project_folder = File.expand_path(File.join(@tmp_root, "my_project"))
end

When /^I run executable "(.*)" with arguments "(.*)"/ do |executable, arguments|
  @stdout = File.expand_path(File.join(@tmp_root, "executable.out"))
  in_project_folder do
    system "#{executable} #{arguments} > #{@stdout} 2> #{@stdout}"
  end
end

Given /^"(.+)" in "(.+)" as one of its plugins$/ do |plugin, path|
  When 'I run executable "ln" with arguments "-s ../../../../'+path+' vendor/plugins/'+plugin+'"'
end

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

When /^I invoke task "rake (.*)"/ do |task|
  @stdout = File.expand_path(File.join(@tmp_root, "rake.out"))
  @stderr = File.expand_path(File.join(@tmp_root, "rake.err"))
  in_project_folder do
    system "rake #{task} --trace > #{@stdout} 2> #{@stderr}"
  end
end

Then /^I should see '([^\']*)'$/ do |text|
  actual_output = File.read(@stdout)
  actual_output.should =~ /#{Regexp.escape(text)}/
end

Then /^I should see '([^\']*)' in (.+)$/ do |text, path|
  in_project_folder do
    content = File.read(path)
    content.should =~ /#{Regexp.escape(text)}/
  end
end

Given /^I replace "(.+)" with "(.+)" in (.+)$/ do |from, to, path|
  in_project_folder do
    content = File.read(path).gsub(from, to)
    File.open(path, 'wb') { |file| file.write(content) }
  end
end
