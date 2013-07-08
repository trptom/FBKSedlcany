class TeamsController < ApplicationController
  def about
    # jen template s textem
  end

  def index_of_teams
    @teams = Team.teams.all
  end

  def index_of_clubs
    @teams = Team.clubs.all
  end

  def show
    @team = Team.find(params[:id])

    if @team.is_club
      render "show_club"
    else
      render "show_team"
    end
  end

  def new
    @team = Team.new

    @form_title = I18n.t("messages.teams.new.title");
    @form_submit = I18n.t("messages.teams.new.create");
  end

  def create
    @team = Team.new(params[:team])

    @res = @team.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @team
        else
          @errors = @team.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :team => @team
          }
        else
          render :json => {
            :state => false,
            :errors => @team.errors
          }
        end
      }
    end
  end

  def edit
    @team = Team.find(params[:id])

    if @team.is_club
      @form_title = I18n.t("messages.teams.edit.title_club");
      @form_submit = I18n.t("messages.teams.edit.update_club");
      render "edit_club"
    else
      @form_title = I18n.t("messages.teams.edit.title_team");
      @form_submit = I18n.t("messages.teams.edit.update_team");
      render "edit_team"
    end
  end

  def update
    @team = Team.find(params[:id])
    @team.update_attributes(params[:team]);

    @res = @team.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @team
        else
          @errors = @team.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :team => @team
          }
        else
          render json: {
            :result => false,
            :errors => @team.errors
          }
        end
      }
    end
  end

  def destroy
    @team = Team.find(params[:id])

    @res = @team.destroy

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

  def squad
    @team = params[:id] ? Team.find(params[:id]) : Team.order(:id).first

    respond_to do |format|
      format.html {}
      format.json {
        players = []
        for player in @team.players.all
          players << player
        end

        render json: {
          :team => @team,
          :players => players
        }
      }
    end
  end
end
