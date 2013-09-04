require 'test_helper'

class PermissionsHelperTest < ActionView::TestCase
  test "has_role" do
    assert true ==  has_role({})
    assert false == has_role({ :role => :admin})
    assert true ==  has_role({ :role => nil, :user => users(:one) })
    assert true ==  has_role({ :role => :root, :user => users(:admin) })
  end
end
