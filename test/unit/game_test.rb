require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "parse cfbu links" do
    assert_equal Game.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2519&onlycontent=1&record_id=82520"), "82520"
    assert_equal Game.get_data_from_cfbu_profile_link("http://fis.cfbu.cz/index.php?pageid=2519&record_id=82520&onlycontent=1"), "82520"
    assert_equal Game.get_data_from_cfbu_profile_link("82520"), "82520"
  end
end
