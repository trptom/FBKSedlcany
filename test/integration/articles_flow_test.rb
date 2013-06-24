# coding:utf-8

require 'test_helper'

class ArticlesFlowTest < ActionDispatch::IntegrationTest
  def simple_test
    login nil

    logout
  end

  def advanced_test
    login :username => "one", :password => "password"

    logout
  end
end
