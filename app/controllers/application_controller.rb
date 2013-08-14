# coding:utf-8
include ApplicationHelper 
include PermissionsHelper

class ApplicationController < ActionController::Base
  protect_from_forgery

  def redirect_if_production
    if (Rails.env.production? || true) && (
        (params[:controller] == "articles" && params[:action] == "search") ||
        (params[:controller] == "teams" && params[:action] == "about") ||
        (params[:controller] == "teams" && params[:action] == "squad") ||
        (params[:controller] == "teams" && params[:action] == "matches")
        (params[:controller] == "users" && params[:action] == "new"))
      redirect_to "/web_not_complete.html"
    end
  end

  before_filter :redirect_if_production

#  #kdyz potrebuju resetovat prihlaseneho uzivatele
#  def aaa
#    login("admin", "root")
#  end
#
#  before_filter :aaa

  before_filter :premissions_filter
end
