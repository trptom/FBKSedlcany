class Hall < ActiveRecord::Base
  has_many :games

  attr_accessible :description, :name

  def self.get_options(atts = nil)
    atts = atts ? atts : {}

    if (atts[:where])
      res = Hall.where(atts[:where])
    else
      res = Hall;
    end

    if (atts[:order_by])
      res = res.order(atts[:order_by])
    end

    ary = Array.new
    if (atts[:empty])
      ary << [ I18n.t("messages.base.no_hall"), "" ]
    end
    res.all.each do |item|
      ary << [item.name, item.id];
    end

    return ary;
  end
end
