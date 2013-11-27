class Event < ActiveRecord::Base
  attr_accessible :description, :end, :name, :start
end
