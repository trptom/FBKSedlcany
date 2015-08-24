module PlayersHelper
  def get_position_hash(param)
    position = []
    
    if (param[:goalkeeper] && param[:goalkeeper][:used])
      position << {
        :id => POSITION[:goalkeeper],
        :sides => nil
      }
    end
    
    if (param[:defender] && param[:defender][:used])
      position << {
        :id => POSITION[:defender],
        :sides => param[:defender][:side]
      }
    end
    
    if (param[:attacker] && param[:attacker][:used])
      position << {
        :id => POSITION[:attacker],
        :sides => param[:attacker][:side]
      }
    end
    
    if position.length == 0
      position = nil
    end
    
    return position
  end
end
