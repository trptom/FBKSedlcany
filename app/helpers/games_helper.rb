# To change this template, choose Tools | Templates
# and open the template in the editor.

module GamesHelper
  def get_season_options_desc(start = Time.now.year, range = GAME_SEASON_MAX_BACK)
    options = []
    for a in 1..range
      options << [start.to_s + "/" + (start+1).to_s, start]
      start = start-1
    end
    return options
  end
end
