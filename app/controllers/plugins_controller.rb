class PluginsController < ApplicationController
  def ckeditor_addplayer
    @list = Player.order(:team_id, :second_name, :first_name).all

    @items = []
    @last = nil
    for player in @list
      if @last == nil || player.team_id != @last.team_id
        if player.team_id != nil
          @items << {
            :label => player.team.name,
            :title => player.team.name
          }
        else
          @items << {
            :label => I18n.t("messages.base.players_without_team"),
            :title => I18n.t("messages.base.players_without_team")
          }
        end
      end

      @items << {
        :value => player.id.to_s + "|" + player.get_name,
        :label => player.get_name,
        :title => player.get_name
      }
      
      @last = player
    end

    respond_to do |format|
      format.json {
        render :json => {
          :items => @items
        }
      }
    end
  end

  def ckeditor_addteam
    @list = Team.order(:short_name).all

    @items = []
    @items << {
      :label => I18n.t("messages.base.teams")
    }
    for team in @list
      link = team.cfbu_profile_link
      @items << {
        :value => (link ? (team.id.to_s + "|") : "") + team.name,
        :label => team.short_name,
        :title => team.name
      }
    end

    respond_to do |format|
      format.json {
        render :json => {
          :items => @items
        }
      }
    end
  end
end
