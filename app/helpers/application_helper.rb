module ApplicationHelper
  def page_not_found
    redirect_to NOT_FOUND_PAGE_URL
  end

  def wrong_params
    page_not_found
  end

  def access_denied
    page_not_found
  end

  def get_admin_menu_structure
    if !current_user
      return nil
    end

    menu = {
      :structure => {
        :articles => [],
        :players => [],
        :teams => []
      },
      :messages => {
        :articles => I18n.t("messages.templates.menu.articles"),
        :players => I18n.t("messages.templates.menu.players"),
        :teams => I18n.t("messages.templates.menu.teams")
      }
    }

    if articles_filter("create", { :user => current_user })
      menu[:structure][:articles] << link_to(I18n.t("messages.templates.menu.create_article"), new_article_path)
    end

    if players_filter("create", { :user => current_user })
      menu[:structure][:players] << link_to(I18n.t("messages.templates.menu.create_player"), new_player_path)
    end

    if teams_filter("create", { :user => current_user })
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.list_of_clubs"), clubs_path)
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.list_of_teams"), teams_path)
      menu[:structure][:teams] << nil; # divider
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.create_club"), new_club_path)
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.create_team"), new_team_path)
    end

    count  =0;
    menu[:structure].keys.sort.each do |key|
      count += menu[:structure][key].length
    end

    return count > 0 ? menu : nil;
  end
end
