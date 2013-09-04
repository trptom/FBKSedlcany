# coding:utf-8

require 'selenium_test_helper'

class ArticlesFlowTest < ActionDispatch::IntegrationTest
  test "simple" do
    login

    click_on "Admin zóna"
    click_on "Články"
    click_on "Vytvořit článek"

    assert_equal new_article_path, current_path

    logout
  end

  test "advanced" do
    login :username => "one", :password => "password"

    logout
  end
end
