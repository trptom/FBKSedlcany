# Class of players' stats. Contains columns for all important stats' items from
# whole season (it means summary of all games). If you want to get detail of
# each single game, you need to access serialized games_descriptor column,
# which contains array of game details and each item of this array consists of
# following items:
# <ul>
#   <li>game_id - integer</li>
#   <li>goals - integer</li>
#   <li>assists - integer</li>
#   <li>ranking - integer</li>
#   <li>:penalty_minutes - integer</li>
#   <li>:red_cards_1 - integer</li>
#   <li>:red_cards_2 - integer</li>
#   <li>:red_cards_3 - integer</li>
#   <li>:position - string</li>
#   <li>description - text (optional)</li>
# </ul>
# This hack is being used because FREE DB has limit 20000 lines per table so I
# can't store each game as a single record.
class PlayerStats < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  belongs_to :league

  serialize :games_descriptor

  attr_accessible :player_id, :league_id, :team_id, :season,
    :games_played, :goals, :assists, :avg_ranking,
    :penalty_minutes, :red_cards_1, :red_cards_2, :red_cards_3,
    :games_descriptor

  def points
    return goals + assists
  end
  
  def update_attributes_from_descriptors
    games_played = 0
    goals = 0
    assists = 0
    avg_ranking = 0
    penalty_minutes = 0
    red_cards_1 = 0
    red_cards_2 = 0
    red_cards_3 = 0
    
    for game in games_descriptor
      games_played = games_played + 1
      goals = goals + game[:goals]
      assists = assists + game[:assists]
      avg_ranking = avg_ranking + game[:ranking]
      penalty_minutes = penalty_minutes + game[:penalty_minutes]
      red_cards_1 = red_cards_1 + game[:red_cards_1]
      red_cards_2 = red_cards_2 + game[:red_cards_2]
      red_cards_3 = red_cards_3 + game[:red_cards_3]
    end
    
    avg_ranking = avg_ranking / games_played
  end
  
  def add_game_desrriptor(data_hash, update = true)
    games_descriptor << data_hash
    
    if update
      update_attributes_from_descriptors
    end
  end
  
  def game_detail(game_id)
    for game in game_descriptors
      if game[:game_id] == game_id
        return game
      end
    end
    return nil
  end
end
