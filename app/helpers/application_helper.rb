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
        :teams => [],
        :users => []
      },
      :messages => {
        :articles => I18n.t("messages.templates.menu.articles"),
        :players => I18n.t("messages.templates.menu.players"),
        :teams => I18n.t("messages.templates.menu.teams"),
        :users => I18n.t("messages.templates.menu.users")
      }
    }

    if articles_filter("create", { :user => current_user })
      menu[:structure][:articles] << link_to(I18n.t("messages.templates.menu.create_article"), new_article_path)
    end

    if players_filter("create", { :user => current_user })
      menu[:structure][:players] << link_to(I18n.t("messages.templates.menu.create_player"), new_player_path)
    end

    if teams_filter("index", { :user => current_user })
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.list_of_clubs"), clubs_path)
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.list_of_teams"), teams_path)
    end
    if teams_filter("create", { :user => current_user })
      if menu[:structure][:teams].length > 0
        menu[:structure][:teams] << nil; # divider
      end
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.create_club"), new_club_path)
      menu[:structure][:teams] << link_to(I18n.t("messages.templates.menu.create_team"), new_team_path)
    end

    if users_filter("index", { :user => current_user })
      menu[:structure][:users] << link_to(I18n.t("messages.templates.menu.list_of_users"), users_path)
    end

    count  =0;
    menu[:structure].keys.sort.each do |key|
      count += menu[:structure][key].length
    end

    return count > 0 ? menu : nil;
  end

  # Funkce s bezpecnostni pojistkou, kdyby nahodou hledani selhalo.
  def check_asset_existency(asset)
    logger.info "searching asset: " + asset
    return Rails.application.assets.find_asset asset
  rescue
    logger.info "asset arror: " + asset
    return false;
  end

  def get_additional_styles
    ctrl_style_url = "pages/" + params[:controller] + "/overall.css"
    page_style_url = "pages/" + params[:controller] + "/" + params[:action] + ".css"

    res = Array.new

    if check_asset_existency ctrl_style_url
      res << asset_path(ctrl_style_url)
    end

    if check_asset_existency page_style_url
      res << asset_path(page_style_url)
    end
	
	logger.info "styles res: " + res

    return res
  end

  def get_additional_scripts
    ctrl_script_url = "pages/" + params[:controller] + "/overall.js"
    page_script_url = "pages/" + params[:controller] + "/" + params[:action] + ".js"

    res = Array.new

    if check_asset_existency ctrl_script_url
      res << asset_path(ctrl_script_url)
    end

    if check_asset_existency page_script_url
      res << asset_path(page_script_url)
    end

	logger.info "scripts res: " + res
	
    return res
  end
end
