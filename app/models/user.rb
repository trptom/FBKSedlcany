# coding:utf-8

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :articles
  has_many :comments

  attr_accessible :activation_expires_at, :activation_state, :activation_token, :password, :password_confirmation, :salt,
    :username, :email, :first_name, :second_name, :role

  serialize :role

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
