# coding:utf-8

require 'simplecov'
SimpleCov.start do
  # odfiltruju testy, aby mi to nekazilo celkovy vysledky
  add_filter "test/"
  # taky vyhodim config - vzdy se projedou cele
  add_filter "config/"

  # zakladni skupiny podle typu souboru
  add_group "Models", "app/models"
  add_group "Controllers", "app/controllers"
  add_group "Mailers", "app/mailers"
  add_group "Uploaders", "app/uploaders"
  add_group "Helpers", "app/helpers"
  # a jeste neco navic
  add_group "Long files (200+)" do |src_file|
    src_file.lines.count > 200
  end
  add_group "Short files (10-)" do |src_file|
    src_file.lines.count <= 10
  end
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#require 'capybara/rspec'

# helper pro prihlasovani/odhlasovani pri funkcnich testech - jinak bz vetsina
# akci nefungovala, protoze by na ne neprihlaseny uzivatel nemel pristup
include Sorcery::TestHelpers::Rails

class ActiveSupport::TestCase
  fixtures :all
end

# trida pro integracni testy (vyuziva gem capybara s driverem selenium)
#class ActionDispatch::IntegrationTest
#  @ACCESS_DENIED_PAGE = "/home/error"
#  @loggenIn = false
#
#  fixtures :all
#  include Capybara::DSL
#
#  def assert_uri(uri)
#    current = URI.parse(current_url)
#    "#{current.path}?#{current.query}".should == uri
#  end
#
#  def login (atts)
#    username = atts && atts[:username] ? atts[:username] : "admin"
#    password = atts && atts[:password] ? atts[:password] : "root"
#    default_page = atts && atts[:page] ? atts[:page] : "/"
#
#    visit default_page
#    click_on 'Přihlášení'
#    fill_in "username", :with => username
#    fill_in "password", :with => password
#    click_on 'Přihlásit se'
#
#    assert_equal default_page, current_path
#    assert page.has_content?(username)
#  end
#
#  def logout
#    click_on 'd1'
#    click_on 'Odhlášení'
#  end
#
#  def setup
#    page.driver.browser.manage.window.maximize
#  end
#
#  def teardown
#    if page.has_content?('Odhlášení')
#      logout
#    end
#  end
#end