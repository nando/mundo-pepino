require 'ostruct'

module MundoPepino
  class Config
    attr_accessor :models_to_clean,
      :model_mappings,
      :field_mappings,
      :relation_model_mappings,
      :url_mappings
    
    def initialize(&block)
      @models_to_clean = []
      @model_mappings, @field_mappings, 
        @relation_model_mappings, @url_mappings = {}, {}, {}, {}
      configure(&block) if block_given?
    end
    
    def configure(&block)
      yield(self)
    end
    
    def models_to_clean
      @models_to_clean ||= []
    end
  end
end
