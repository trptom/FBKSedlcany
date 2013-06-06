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
        :articles => []
      },
      :messages => {
        :articles => I18n.t("messages.templates.menu.articles")
      }
    }

    if articles_filter("create", { :user => current_user })
      menu[:structure][:articles] << link_to(I18n.t("messages.templates.menu.create_article"), new_article_path)
    end

    count  =0;
    menu[:structure].keys.sort.each do |key|
      count += menu[:structure][key].length
    end

    return count > 0 ? menu : nil;
  end
end
