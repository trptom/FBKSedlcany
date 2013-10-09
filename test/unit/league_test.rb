require 'test_helper'

class LeagueTest < ActiveSupport::TestCase
  test "parse cfbu links" do
    assert_equal League.get_data_from_cfbu_profile_link("http://www.cfbu.cz/redakcni_system/index.php?tabulka=1&soutez=5131"), "5131"
    assert_equal League.get_data_from_cfbu_profile_link("http://www.cfbu.cz/redakcni_system/index.php?soutez=5131&tabulka=1"), "5131"
    assert_equal League.get_data_from_cfbu_profile_link("5131"), "5131"
    assert_equal League.get_data_from_cfbu_profile_link(nil), nil
  end
end
