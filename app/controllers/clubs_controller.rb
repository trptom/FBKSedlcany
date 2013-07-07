class ClubsController < ApplicationController
  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
  end

  def new
    @club = Club.new

    @form_title = I18n.t("messages.clubs.new.title");
    @form_submit = I18n.t("messages.clubs.new.create");
  end

  def create
    @res = ActiveRecord::Base.transaction do
      @club = Club.new(params[:club])
      @club.save
      @team = @club.create_default_team
      @team.save
    end

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

    @form_title = I18n.t("messages.clubs.edit.title");
    @form_submit = I18n.t("messages.clubs.edit.create");
  end

  def update

  end

  def destroy
    @club = Club.find(params[:id])

    @res = @club.destroy

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
