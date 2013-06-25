# coding:utf-8

class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  has_many :articles
  has_many :comments

  attr_accessible :activation_expires_at, :activation_state, :activation_token,
    :password, :password_confirmation, :salt, :authentications_attributes,
    :username, :email, :first_name, :second_name, :role,
    :blocked, :block_expires_at

  serialize :role


  def is_blocked
    if block_expires_at != nil
      if Time.current > block_expires_at
        unblock
        return false
      else
        return true
      end
    else
      return blocked
    end
  end

  def block(to_date)
    update_attributes(
      :block_expires_at => to_date,
      :blocked => true
    )
    save
  end

  def unblock
    update_attributes(
      :block_expires_at => nil,
      :blocked => false
    )
    save
  end

  def get_block_state_str(atts)
    atts = atts.kind_of?(Hash) ? atts : Hash.new
    if is_blocked
      atts[:blocked_str] = atts[:blocked_str] ? atts[:blocked_str] : I18n.t("messages.base.blocked")
      if block_expires_at != nil
        return atts[:blocked_str] + " (" + I18n.t("messages.base.block_expires_at") +
            ": " + I18n.l(block_expires_at) + ")"
      else
        return atts[:blocked_str]
      end
    else
      return atts[:not_blocked_str] ? atts[:not_blocked_str] : I18n.t("messages.base.not_blocked")
    end
  end

  def get_role_str(atts)
    atts = atts.kind_of?(Hash) ? atts : Hash.new
    ret = "";
    for r in role
      if ret != ""
        ret +=  atts[:separator] ? atts[:separator] : ", "
      end
      ret += I18n.t(ROLE_MESSAGES[r])
    end
    return ret
  end

  def is_active
    return activation_state == "active"
  end

  validates :username,
    :format => { :with => /^[a-zA-Z0-9\-\.\_]{3,30}$/, :message => VALIDATION_ERROR_MESSAGE["user"]["username"]["format"] },
    :uniqueness => { :case_sensitive => false, :message => VALIDATION_ERROR_MESSAGE["user"]["username"]["uniqueness"] }

  validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => VALIDATION_ERROR_MESSAGE["user"]["email"]["format"] },
    :uniqueness => { :case_sensitive => false, :message => VALIDATION_ERROR_MESSAGE["user"]["email"]["uniqueness"] }

  validates :password,
    :length => { :minimum => 3, :maximum => 255, :message => VALIDATION_ERROR_MESSAGE["user"]["password"]["length"] },
    :confirmation => { :message => VALIDATION_ERROR_MESSAGE["user"]["password"]["confirmation"] },
    :allow_blank => false,
    :allow_nil => false,
  :if => :password

  validates :first_name,
    :format => { :with => /^(|.{2,})$/, :message => VALIDATION_ERROR_MESSAGE["user"]["first_name"] },
    :allow_nil => true,
    :allow_blank => true

  validates :second_name,
    :format => { :with => /^(|.{2,})$/, :message => VALIDATION_ERROR_MESSAGE["user"]["second_name"] },
    :allow_nil => true,
    :allow_blank => true
end
