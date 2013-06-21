class ClubsController < ApplicationController
  def index
    @clubs = Club.all
  end

  def show

  end

  def new
    @club = Club.new

    @form_submit = I18n.t("messages.clubs.new.create");
  end

  def create
    @club = Club.new(params[:club])

    @res = @club.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @club
        else
          @errors = @club.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :club => @club
          }
        else
          render :json => {
            :state => false
          }
        end
      }
    end
  end

  def edit
    @club = Club.find(params[:id])

    @form_submit = I18n.t("messages.clubs.edit.create");
  end

  def update

  end

  def destroy
    @club = Club.find(params[:id])

    @res = Club.destroy

    respond_to do |format|
      format.html {
        redirect_to clubs_path
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end
end
