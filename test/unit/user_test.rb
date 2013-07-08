require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create_and_activate" do
    @user = User.new(
      :username => "trptom",
      :email => "nonexistingemail@idontwanttosendmails.cz",
      :password => "aaabbb",
      :password_confirmation => "aaabbb")
    assert @user.save
    assert @user.activate!
    assert @user.activation_state == "active"
    assert @user.is_active
  end

  test "blocking" do
    @user = users(:one)
    assert !@user.is_blocked
    @user.block
    assert @user.is_blocked
    @user.unblock
    assert !@user.is_blocked

    @user.block(DateTime.new(2012, 1, 1, 0, 0))
    assert !@user.is_blocked

    @user.block(DateTime.new(2020, 1, 1, 0, 0))
    assert @user.is_blocked

    @user.block(DateTime.new(2012, 1, 1, 0, 0))
    assert !@user.is_blocked
  end
end
