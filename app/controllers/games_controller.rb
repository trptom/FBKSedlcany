class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    
    @game.season = Time.now.year
    @game.home_team = nil
    @game.away_team = nil
    @game.league = nil
    @game.hall = nil
    @game.organizer = nil

    @messages = {
      :title => I18n.t("messages.base.new_game"),
      :submit => I18n.t("messages.base.create_game")
    }
  end

  def create
    @game = Game.new(params[:game])
    @game.creator = current_user
    @game.editor = current_user
    
    @res = @game.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to edit_game_path(@game), :notice => I18n.t("messages.base.record_created")
        else
          @errors = @game.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :game => @game
          }
        else
          render :json => {
            :state => false,
            :errors => @game.errors
          }
        end
      }
    end
  end

  def edit
    @game = Game.find(params[:id])

    @messages = {
      :title => I18n.t("messages.base.edit_of_game"),
      :submit => I18n.t("messages.base.update_game"),
      :detail => I18n.t("messages.base.go_to_detail"),
      :delete => I18n.t("messages.base.delete_game")
    }
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(params[:game]);
    
    @game.score = {
      "total" => {
        "home" => params[:game][:score][:total][:home],
        "away" => params[:game][:score][:total][:away]
      },
      "periods" => {
        "home" => params[:game][:score][:periods][:home],
        "away" => params[:game][:score][:periods][:away]
      },
      "note" => params[:game][:score][:note]
    }
    
    @game.editor = current_user
    
    @res = @game.save

    respond_to do |format|
      format.html {
        if @res
          redirect_back(I18n.t("messages.base.saved"), games_url)
        else
          @errors = @game.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :game => @game
          }
        else
          render json: {
            :result => false,
            :errors => @game.errors
          }
        end
      }
    end
  end

  def destroy
    @game = Game.find(params[:id])

    @res = @game.destroy

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
  
  # Adds new PlayerStats record to _Player_ and saves _Players_' id into _Game_
  # stats.
  #
  # ==== Required params
  # _id_:: id of _Game_ into which are stats appended.
  # _player_id_:: id of _Player_ who owns this stats.
  # _team_id_:: id of _Team_ for which _Player_ played this game.
  # _player_team_:: name of _Team_ for which _Player_ played this game. ("home"
  # or "away")
  # _player_stats_:: hash of stats. For better understanding what needs to be
  # filled in, see _PlayerStats_' class documentation.
  #
  # ==== Format
  # * JSON
  def add_stats
    @game = Game.find(params[:id])
    @player_stats_all = Player.find(params[:player_id]).player_stats.where(
      :season => @game.season,
      :league_id => @game.league_id,
      :team_id => params[:team_id]
    )
    
    if @player_stats_all.count > 0
      @player_stats = @player_stats_all.first
    else
      @player_stats = PlayerStats.new(
        :player_id => params[:player_id],
        :league_id => @game.league_id,
        :team_id => params[:team_id]
      )
    end
    
    @player_stats.add_game_desrriptor(params[:player_stats])
    @game.stats[params[:player_team] << params[:player_id]]
    
    ActiveRecord::Base.transaction do
      @player_stats.save
      @game.save
    end
  end
  
  def delete_stats
    
  end
end
