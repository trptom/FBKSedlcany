require 'test_helper'

class PermissionsHelperTest < ActionController::TestCase
  include PermissionsHelper
  
  def test_has_role
    login_user(users(:admin))

    assert true ==  has_role({})
    assert false == has_role({ :role => :admin})
    assert true ==  has_role({ :role => nil, :user => User.first })
    assert true ==  has_role({ :role => :admin, :user => users(:admin) })
  end
end
