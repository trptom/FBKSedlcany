require 'functional_test_helper'

class UsersControllerTest < FunctionalTestHelper
  test "get index" do
    get :index
    assert_response :success
  end

  test "get show" do
    get :show, id: users(:one).id
    assert_response :success
  end

  test "get edit" do
    get :edit, id: users(:one).id
    assert_response :success
  end

  test "get change_password" do
    get :change_password, id: users(:one).id
    assert_response :success
  end

  test "get new" do
    logout
    get :new
    assert_response :success
  end
end
