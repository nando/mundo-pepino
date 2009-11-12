module ApplicationHelper
  def setup_orchard(orchard)
    returning orchard do |o|
      o.terraces.build
    end
  end
end
