# coding:utf-8

class UserMailer < ActionMailer::Base
  default from: "info@kucharka.com"

  def activation_needed_email(user)
    @user = user
    @url = "http://fbksedlcany.herokuapp.com"
    @url_activation  = "http://fbksedlcany.herokuapp.com/users/#{user.activation_token}/activate?src=email"
    mail(:to => user.email,
         :subject => I18n.t("messages.mailers.user_mailer.welcome", :teamName => TEAM_NAME))
  end

  def activation_success_email(user)
    @user = user
    @url = "http://fbksedlcany.herokuapp.com"
    mail(:to => user.email,
         :subject => I18n.t("messages.mailers.user_mailer.account_activated"))
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token, :host => "fbksedlcany.herokuapp.com")
    mail(:to => user.email,
         :subject => I18n.t("messages.mailers.user_mailer.password_updated"))
  end
end
