# Borrowed from DrNic's culerity
gem 'cucumber'
require 'cucumber'
gem 'rspec'
require 'spec'

Before do
  @tmp_root  = File.dirname(__FILE__) + "/../../tmp"
  @home_path = File.expand_path(File.join(@tmp_root, "home"))
  @lib_path  = File.expand_path(File.dirname(__FILE__) + "/../../lib")
  FileUtils.rm_rf   @tmp_root
  FileUtils.mkdir_p @home_path
  ENV['HOME'] = @home_path
end

require 'rubigen'
require 'rubigen/helpers/generator_test_helper'
include RubiGen::GeneratorTestHelper

SOURCES = Dir[File.dirname(__FILE__) + "/../../rails_generators"].map do |f|
  RubiGen::PathSource.new(:test, File.expand_path(f))
end
module CommonHelpers
  def in_tmp_folder(&block)
    FileUtils.chdir(@tmp_root, &block)
  end

  def in_project_folder(&block)
    project_folder = @active_project_folder || @tmp_root
    FileUtils.chdir(project_folder, &block)
  end

  def in_home_folder(&block)
    FileUtils.chdir(@home_path, &block)
  end

  def force_local_lib_override(options = {})
    target_path = options[:target_path] || options[:target_file] || options[:target] || 'Rakefile'
    in_project_folder do
      contents = File.read(target_path)
      File.open(target_path, "w+") do |f|
        f << "$:.unshift('#{@lib_path}')\n"
        f << contents
      end
    end
  end

  def setup_active_project_folder project_name
    @active_project_folder = File.join(@tmp_root, project_name)
    @project_name = project_name
  end
end

World(CommonHelpers)

module Matchers
  def contain(expected)
    simple_matcher("contain #{expected.inspect}") do |given, matcher|
      matcher.failure_message = "expected #{given.inspect} to contain #{expected.inspect}"
      matcher.negative_failure_message = "expected #{given.inspect} not to contain #{expected.inspect}"
      given.index expected
    end
  end
end

World(Matchers)