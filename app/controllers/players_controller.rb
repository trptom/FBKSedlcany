class PlayersController < ApplicationController
  def show
    
  end

  def new
    @player = Player.new

    @form_submit = I18n.t("messages.players.new.create")
  end

  def create

  end

  def edit
    @player = Player.find(:player_id)

    @form_submit = I18n.t("messages.players.edit.update")
  end

  def update

  end

  def destroy

  end
end
