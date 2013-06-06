require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_create_and_activate
    @user = User.new(
      :username => "trptom",
      :email => "nonexistingemail@idontwanttosendmails.cz",
      :password => "aaabbb",
      :password_confirmation => "aaabbb")
    assert @user.save
    assert @user.activate!
    assert @user.active
  end
end
