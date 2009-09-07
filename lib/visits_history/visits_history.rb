module MundoPepino
  module VisitsHistory
    def do_visit(url)
      @visits ||= []
      @visits << url
      visit url
    end
    
    def last_visited
      @visits.last
    end
  end
end
