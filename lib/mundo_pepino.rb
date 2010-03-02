$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'mundo_pepino/base'
require 'mundo_pepino/implementations_api'
require 'mundo_pepino/implementations'
require 'mundo_pepino/resources_history'
require 'mundo_pepino/visits_history'
require 'mundo_pepino/version'
require 'mundo_pepino/config'

require 'string-mapper'

World(MundoPepino)

module MundoPepino
  include Base
  include ImplementationsApi
  include Implementations
  include ResourcesHistory
  include VisitsHistory

  class << self
    attr_accessor :world 
    def extended(current_world)
      self.world = current_world
      common_mappings
      language_specific_mappings
      user_specific_mappings
    end

    def common_mappings
      String.add_mapper(:number) {|str| str.to_i}
      String.add_mapper(:model) {|str|
        begin
          c = str.singularize.capitalize.constantize
          c.superclass == ActiveRecord::Base ? c : nil
        rescue
          nil
        end
      }
      String.add_mapper :field
      String.add_mapper :crud_action
      String.add_mapper :relation_model
      String.add_mapper(:content_type,
        /\.png$/   => 'image/png',
        /\.jpe?g$/ => 'image/jpg',
        /\.gif$/   => 'image/gif') {|str| 'text/plain'}
      String.add_mapper(:underscored) {|string| string.gsub(/ +/, '_')}
      String.add_mapper(:unquoted) {|str| str =~ /^['"](.*)['"]$/ ? $1 : str}
      String.add_mapper(:regexp) {|str| str =~ /\/.+\/[a-z]*/ ? eval(str) : /#{Regexp.escape(str)}/m }
      String.add_mapper(:translated) do |str|
        if str =~ /^[a-z_]+\.[a-z_]+[a-z_\.]+$/
          I18n.translate(str, :default => str)
        elsif str =~ /^([a-z_]+\.[a-z_]+[a-z_\.]+),(\{.+\})$/
          I18n.translate($1, {:default => str}.merge(eval($2)))
        else
          str
        end
      end
      String.add_mapper(:month) {|month| month.capitalize}
      String.add_mapper(:real_value) {|value| value} # true, false...
      String.add_mapper(:user_page)
      String.add_mapper(:page) do |str|
        str.to_user_page || (str =~ /^\/.*$|^https?:\/\//i ? str : nil)
      end
    end

    def config
      @config ||= Config.new
    end

    def configure(&block)
      config.configure(&block)
    end

    def clean_models
      config.models_to_clean.each do |model|
        model.destroy_all
        model.delete_all if model.count > 0
        end      
      end

    def user_specific_mappings
      config.model_mappings.each {|k,v| String.model_mappings[k] = v}
      config.relation_model_mappings.each {|k,v| String.relation_model_mappings[k] = v}
      config.field_mappings.each {|k,v| String.field_mappings[k] = v}
      # url_mappings are deprecated, use page_mappings instead
      config.url_mappings.each {|k,v| String.user_page_mappings[k] = v}
      config.page_mappings.each {|k,v| String.user_page_mappings[k] = v}
    end
  end
end
