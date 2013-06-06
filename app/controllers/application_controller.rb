# coding:utf-8
include ApplicationHelper 
include PermissionsHelper

class ApplicationController < ActionController::Base
  protect_from_forgery

#  kdyz potrebuju resetovat prihlaseneho uzivatele
  def aaa
    login("admin", "root")
  end

  before_filter :aaa
end
