class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new

    @form_title = I18n.t("messages.games.new.title");
    @form_submit = I18n.t("messages.games.new.create");
  end

  def create
    @game = Game.new(params[:game])
    @res = @game.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @game
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

    @form_title = I18n.t("messages.games.edit.title");
    @form_submit = I18n.t("messages.games.edit.update");
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(params[:game]);
    @res = @game.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to @game
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
