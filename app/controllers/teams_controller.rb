class TeamsController < ApplicationController
  def about
    # jen template s textem
  end

  def index_of_teams
    @teams = Team.teams.all
    @new_url = "/teams/new_team"

    @messages = {
      :title => I18n.t("messages.base.list_of_teams"),
      :count => I18n.t("messages.base.players_count"),
      :delete_confirmation => I18n.t("messages.teams.index.delete_team_confirmation")
    }
  end

  def index_of_clubs
    @teams = Team.clubs.all
    @new_url = "/teams/new_club"

    @messages = {
      :title => I18n.t("messages.base.list_of_clubs"),
      :count => I18n.t("messages.base.teams_count"),
      :delete_confirmation => I18n.t("messages.teams.index.delete_club_confirmation")
    }
  end

  def show
    @team = Team.find(params[:id])

    if @team.is_club
      render "show_club"
    else
      render "show_team"
    end
  end

  def new_team
    @team = Team.new

    @messages = {
      :title => I18n.t("messages.base.new_team"),
      :logo => I18n.t("messages.base.logo_of_team"),
      :submit => I18n.t("messages.base.create_team")
    }
  end

  def new_club
    @team = Team.new
    @team.club_id = nil

    @messages = {
      :title => I18n.t("messages.base.new_club"),
      :logo => I18n.t("messages.base.logo_of_club"),
      :submit => I18n.t("messages.base.create_club")
    }
  end

  def create
    @team = Team.new(params[:team])

    @res = @team.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to edit_team_path(@team), :notice => I18n.t("messages.base.record_created")
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
      @messages = {
        :title => I18n.t("messages.base.edit_of_club"),
        :logo => I18n.t("messages.base.logo_of_club"),
        :submit => I18n.t("messages.base.update_club"),
        :detail => I18n.t("messages.base.go_to_detail"),
        :delete => I18n.t("messages.base.delete_club")
      }
      render "edit_club"
    else
      @messages = {
        :title => I18n.t("messages.base.edit_of_team"),
        :logo => I18n.t("messages.base.logo_of_team"),
        :submit => I18n.t("messages.base.update_team"),
        :detail => I18n.t("messages.base.go_to_detail"),
        :delete => I18n.t("messages.base.delete_team")
      }
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
          redirect_back(I18n.t("messages.base.saved"), @team.is_club ? "/teams/index_of_clubs" : "/teams/index_of_teams")
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
    @is_club = @team.is_club

    @res = @team.destroy

    respond_to do |format|
      format.html {
        if @is_club
          redirect_back I18n.t("messages.base.club_deleted"), "/teams/index_of_clubs"
        else
          redirect_back I18n.t("messages.base.team_deleted"), "/teams/index_of_teams"
        end
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end

  def squad
    @team = params[:id] ? Team.find(params[:id]) : Team.where(:name => TEAM_NAME).first
    @players = @team.squad.order(:second_name, :first_name).all

    respond_to do |format|
      format.html {
      }
      format.json {
        players = []
        for player in @players
          players << player
        end

        render json: {
          :team => @team,
          :players => players
        }
      }
    end
  end
  
  def games
    @team = params[:id] ? Team.find(params[:id]) : Team.where(:name => TEAM_NAME).first
    
    respond_to do |format|
      format.html {
      }
      format.json {
        games = []
        for game in @team.games.all
          games << game
        end

        render json: {
          :team => @team,
          :players => players
        }
      }
    end
  end
end
