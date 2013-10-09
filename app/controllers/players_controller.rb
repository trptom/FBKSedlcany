class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new

    @form_title = I18n.t("messages.players.new.title")
    @form_submit = I18n.t("messages.players.new.create")
  end

  def create
    @player = Player.new(params[:player])

    @res = @player.save

    respond_to do |format|
      format.html {
        if @res
          redirect_to edit_player_path(@player), :notice => I18n.t("messages.base.record_created")
        else
          @errors = @player.errors
          render action: "new"
        end
      }
      format.json {
        if @res
          render :json => {
            :state => true,
            :player => @player
          }
        else
          render :json => {
            :state => false,
            :errors => @player.errors
          }
        end
      }
    end
  end

  def edit
    @player = Player.find(params[:id])

    @form_title = I18n.t("messages.players.edit.title")
    @form_submit = I18n.t("messages.players.edit.update")
  end

  def update
    @player = Player.find(params[:id])
    @player.update_attributes(params[:player]);

    @res = @player.save

    respond_to do |format|
      format.html {
        if @res
          redirect_back(I18n.t("messages.base.saved"), players_path)
#          redirect_to @player
        else
          @errors = @player.errors
          render action: "edit"
        end
      }
      format.json {
        if @res
          render json: {
            :result => true,
            :player => @player
          }
        else
          render json: {
            :result => false,
            :errors => @player.errors
          }
        end
      }
    end
  end

  def destroy
    @player = Player.find(params[:id])

    @res = @player.destroy

    respond_to do |format|
      format.html {
        redirect_back I18n.t("messages.base.player_deleted"), players_path
      }
      format.json {
        render json: {
          :result => @res
        }
      }
    end
  end

  def index
    @players = Player.order(:second_name, :first_name).all
  end
end
