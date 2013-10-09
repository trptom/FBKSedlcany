require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test "parse cfbu likns" do
    assert_equal Team.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2521&onlycontent=1&team_id=11226"), "11226"
    assert_equal Team.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2521&team_id=11226&onlycontent=1"), "11226"
    assert_equal Team.get_data_from_cfbu_profile_link("11226"), "11226"
    assert_equal Team.get_data_from_cfbu_profile_link(nil), nil
  end
end
