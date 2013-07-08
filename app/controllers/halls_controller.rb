class HallsController < ApplicationController
  def index
    @halls = Hall.all
  end

  def show
    @hall = Hall.find(params[:id])
  end

  def new
    @hall = Hall.new

    @form_title = I18n.t("messages.halls.new.title");
    @form_submit = I18n.t("messages.halls.new.create");
  end

  def create
    @hall = Hall.new(params[:hall])
    @res = @hall.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @hall
        else
          @errors = @hall.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :hall => @hall
          }
        else
          render :json => {
            :state => false,
            :errors => @hall.errors
          }
        end
      }
    end
  end

  def edit
    @hall = Hall.find(params[:id])

    @form_title = I18n.t("messages.halls.edit.title");
    @form_submit = I18n.t("messages.halls.edit.update");
  end

  def update
    @hall = Hall.find(params[:id])
    @hall.update_attributes(params[:hall]);
    @res = @hall.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @hall
        else
          @errors = @hall.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :hall => @hall
          }
        else
          render json: {
            :result => false,
            :errors => @hall.errors
          }
        end
      }
    end
  end

  def destroy
    @hall = Hall.find(params[:id])

    @res = @hall.destroy

    respond_to do |format|
      format.html {
        redirect_to :back
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
