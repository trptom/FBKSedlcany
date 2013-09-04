require 'functional_test_helper'

class HomeControllerTest < FunctionalTestHelper
  test "get_all" do
    get :index
    assert_response :success

    get :error
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get index through home" do
    get "/home"
    assert_response :success
  end
end
