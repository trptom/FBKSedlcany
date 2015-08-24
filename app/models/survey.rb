class Survey < ActiveRecord::Base
  attr_accessible :code, :description, :name, :active
end
