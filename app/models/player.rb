# To change this template, choose Tools | Templates
# and open the template in the editor.

class Player < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :nick_name, :birthday, :note

  belongs_to :team

  mount_uploader :image, PlayerIconUploader

  def self.get_name
    if (self.first_name == nil && self.second_name == nil)
      return nil;
    end

    if (self.first_name == nil)
      return self.second_name
    end

    if (self.second_name == nil)
      return self.first_name
    end

    return self.first_name + " " + self.second_name
  end

  def self.get_name_including_nick
    if (self.nick_name != nil)
      return self.nick_name
    end

    return self.get_name
  end
end
