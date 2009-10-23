require 'ostruct'

module MundoPepino
  class Config
    attr_writer :models_to_clean
    
    def initialize(&block)
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
