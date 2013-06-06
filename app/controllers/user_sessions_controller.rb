# coding:utf-8

class UserSessionsController < ApplicationController
  before_filter :require_login, :only => [:destroy]

  def create
    respond_to do |format|
      if params[:username] && params[:password] &&
          @user = login(params[:username],params[:password])
        format.html {
          redirect_to("/", notice: I18n.t("messages.user_sessions.create.succesfull"))
        }
        format.json {
          render :json => {
            :state => true,
            :user => @user
          }
        }
      else
        format.html {
          redirect_to( "/home/error", notice: I18n.t("messages.user_sessions.create.failed") )
        }
        format.json {
          render :json => { :state => false }
        }
      end
    end
  end

  def destroy
    logout
    redirect_to( "/", :notice => I18n.t("messages.user_sessions.destroy.succesfull"))
  end
end