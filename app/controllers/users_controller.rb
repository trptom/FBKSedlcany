class UsersController < ApplicationController
  def show
    if (params[:id] || current_user)
      @user = User.find_by_id(params[:id] ? params[:id] : current_user.id)
    end
    
    if !@user
      page_not_found
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  def new
    @user = User.new
  end

  def create

  end
end
