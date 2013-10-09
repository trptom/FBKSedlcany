require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "parse cfbu links" do
    assert_equal Player.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2501&onlycontent=1&personal_id=0708280071"), "0708280071"
    assert_equal Player.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2501&personal_id=0708280071&onlycontent=1"), "0708280071"
    assert_equal Player.get_data_from_cfbu_profile_link("0708280071"), "0708280071"
    assert_equal Player.get_data_from_cfbu_profile_link(nil), nil
  end
end
