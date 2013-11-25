class Wiki < ActiveRecord::Base
  attr_accessible :content, :name, :section, :show_in_menu
  
  scope :menu, -> {
    where(:show_in_menu => true).order(:section, :name)
  }
  
  def self.get_menu_structure
    menu = {}
    for item in Wiki.menu
      if (!menu[item.section])
        menu[item.section] = []
      end
      menu[item.section] << item
    end
    return menu
  end
end
