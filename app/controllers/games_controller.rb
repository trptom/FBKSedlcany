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
      :total => {
        :home => params[:game][:score][:total][:home],
        :away => params[:game][:score][:total][:away]
      },
      :periods => {
        :home => params[:game][:score][:periods][:home],
        :away => params[:game][:score][:periods][:away]
      },
      :note => params[:game][:score][:note]
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
end
