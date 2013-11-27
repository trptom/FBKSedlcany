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
        :leagues => [],
        :teams => [],
        :games => [],
        :halls => [],
        :users => [],
        :images => [],
        :wikis => [],
        :events => []
      },
      :messages => {
        :articles => I18n.t("messages.base.articles"),
        :players => I18n.t("messages.base.players"),
        :leagues => I18n.t("messages.base.leagues"),
        :teams => I18n.t("messages.base.teams"),
        :games => I18n.t("messages.base.games"),
        :halls => I18n.t("messages.base.halls"),
        :users => I18n.t("messages.base.users"),
        :images => I18n.t("messages.base.images"),
        :wikis => I18n.t("messages.base.wiki_pages"),
        :events => I18n.t("messages.base.events")
      }
    }

    # CLANKY
    if articles_filter("new", { :user => current_user })
      menu[:structure][:articles] << link_to(I18n.t("messages.base.create_article"), new_article_path)
    end

    # HRACI
    if players_filter("index", { :user => current_user })
      menu[:structure][:players] << link_to(I18n.t("messages.base.list_of_players"), players_path)
    end
    if players_filter("new", { :user => current_user })
      menu[:structure][:players] << link_to(I18n.t("messages.base.create_player"), new_player_path)
    end

    # LIGY
    if leagues_filter("index", { :user => current_user })
      menu[:structure][:leagues] << link_to(I18n.t("messages.base.list_of_competitions"), leagues_path)
    end
    if leagues_filter("new", { :user => current_user })
      menu[:structure][:leagues] << link_to(I18n.t("messages.base.create_competition"), new_league_path)
    end

    # TYMY
    if teams_filter("index_of_clubs", { :user => current_user })
      menu[:structure][:teams] << link_to(I18n.t("messages.base.list_of_clubs"), "/teams/index_of_clubs")
    end
    if teams_filter("index_of_teams", { :user => current_user })
      menu[:structure][:teams] << link_to(I18n.t("messages.base.list_of_teams"), "/teams/index_of_teams")
    end
    if teams_filter("new", { :user => current_user })
      if menu[:structure][:teams].length > 0
        menu[:structure][:teams] << nil; # divider
      end
      menu[:structure][:teams] << link_to(I18n.t("messages.base.create_club"), new_team_path)
      menu[:structure][:teams] << link_to(I18n.t("messages.base.create_team"), new_team_path)
    end

    # ZAPASY
    if games_filter("index", { :user => current_user })
      menu[:structure][:games] << link_to(I18n.t("messages.base.list_of_games"), games_path)
    end
    if games_filter("new", { :user => current_user })
      menu[:structure][:games] << link_to(I18n.t("messages.base.create_game"), new_game_path)
    end

    # HALY
    if halls_filter("index", { :user => current_user })
      menu[:structure][:halls] << link_to(I18n.t("messages.base.list_of_halls"), halls_path)
    end
    if halls_filter("new", { :user => current_user })
      menu[:structure][:halls] << link_to(I18n.t("messages.base.create_hall"), new_hall_path)
    end

    # UZIVATELE
    if users_filter("index", { :user => current_user })
      menu[:structure][:users] << link_to(I18n.t("messages.base.list_of_users"), users_path)
    end

    # OBRAZKY
    if images_filter("index", { :user => current_user })
      menu[:structure][:images] << link_to(I18n.t("messages.base.list_images"), images_path)
    end
    
    # WIKINY
    if wikis_filter("index", { :user => current_user })
      menu[:structure][:wikis] << link_to(I18n.t("messages.base.list_of_wiki_pages"), wikis_path)
    end
    
    # UDALOSTI
    if events_filter("index", { :user => current_user })
      menu[:structure][:events] << link_to(I18n.t("messages.base.list_of_events"), events_path)
    end

    # ... a tady to vsechno spocitam, jestli mam co vratit ...
    count  =0;
    menu[:structure].keys.sort.each do |key|
      count += menu[:structure][key].length
    end

    return count > 0 ? menu : nil;
  end

  # Funkce s bezpecnostni pojistkou, kdyby nahodou hledani selhalo.
  def check_asset_existency(asset)
    logger.info "searching asset: " + asset
	#ret = File.exists?(File.join(Rails.public_path, 'assets', asset))
	#logger.info "asset result: " + ret.to_s
	#return ret;
    return Rails.application.assets.find_asset asset
  rescue
    logger.info "asset error: " + asset
    return false;
  end

  def get_additional_styles
    ctrl_style_url = "skins/modern/pages/" + params[:controller] + "/overall.css"
    page_style_url = "skins/modern/pages/" + params[:controller] + "/" + params[:action] + ".css"

    res = Array.new

    if check_asset_existency ctrl_style_url
      res << "/assets/#{ctrl_style_url}"
    end

    if check_asset_existency page_style_url
      res << "/assets/#{page_style_url}"
    end
	
	logger.info "styles res: " + res.to_s

    return res
  end

  def get_additional_scripts
    ctrl_script_url = "pages/" + params[:controller] + "/overall.js"
    page_script_url = "pages/" + params[:controller] + "/" + params[:action] + ".js"

    res = Array.new

    if check_asset_existency ctrl_script_url
      res << "/assets/#{ctrl_script_url}"
    end

    if check_asset_existency page_script_url
      res << "/assets/#{page_script_url}"
    end

	logger.info "scripts res: " + res.to_s
	
    return res
  end
end
