class UsersController < ApplicationController
  def index
    
  end

  def show
    params[:id] = params[:id] ? params[:id] : (current_user ? current_user.id : nil)
    @user = User.find_by_id(params[:id])
    
    if !@user
      page_not_found
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id]);
    @user.update_attributes(params[:user]);

    @res = @user.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @user, notice: I18n.t("messages.users.update.success")
        else
          @errors = @user.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :user => @user
          }
        else
          render :json => {
            :state => false
          }
        end
      }
    end
  end

  def change_password
    @user = User.find(params[:id])
  end

  def update_password
    @user = User.find(params[:id])
    if (@user && User.authenticate(@user.username, params[:user][:old_password]))
      @user.password_confirmation = params[:user][:password_confirmation]
      # the next line clears the temporary token and updates the password
      @res = @user.change_password!(params[:user][:password])
      if !@res
        @user.errors.add(:password, I18n.t("messages.users.update_password.error") )
      end
    else
      @res = false
      @user.errors.add(:old_password, I18n.t("messages.users.update_password.wrong_old") )
    end

    respond_to do |format|
      format.html {
        if @res
          redirect_to @user, :notice => I18n.t("messages.users.update_password.success")
        else
          @errors = @user.errors
          render action: "change_password"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :user => @user
          }
        else
          render :json => {
            :state => false,
            :errors => @user.errors
          }
        end
      }
    end
  end

  def reset_password
    # jen renderuju formular
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @res = @user.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to "/", notice: I18n.t("messages.users.create.success")
        else
          @errors = @user.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :user => @user
          }
        else
          render :json => {
            :state => false
          }
        end
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @res = @user.destroy

    respond_to do |format|
      format.html {
        redirect_to :back
      }
      format.json {
        render :json => {
          :status => @res
        }
      }
    end
  end

  def block
    @user = User.find(params[:id])
    @user.block(DateTime.new(
        params[:user]["block_expires_at(1i)"].to_i,
        params[:user]["block_expires_at(2i)"].to_i,
        params[:user]["block_expires_at(3i)"].to_i,
        params[:user]["block_expires_at(4i)"].to_i,
        params[:user]["block_expires_at(5i)"].to_i))

    redirect_to :back
  end

  def unblock
    @user = User.find(params[:id])
    @user.unblock

    redirect_to :back
  end

  def activate
    @user = User.find(params[:id])
    @user.activate!

    redirect_to :back
  end
end
