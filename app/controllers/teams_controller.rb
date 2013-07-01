class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
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
            :state => false
          }
        end
      }
    end
  end

  def edit
    @team = Team.find(params[:id])

    @form_title = I18n.t("messages.teams.edit.title");
    @form_submit = I18n.t("messages.teams.edit.create");
  end

  def update

  end

  def destroy
    @team = Team.find(params[:id])

    @res = @team.destroy

    respond_to do |format|
      format.html {
        redirect_to teams_path
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
