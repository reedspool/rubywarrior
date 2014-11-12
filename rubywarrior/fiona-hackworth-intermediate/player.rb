load 'myWarrior.rb'
load 'StrategicWarrior.rb'
load 'util.rb'

class Player
  def play_turn(warrior)
  	w = StrategicWarrior.new warrior
  	
  	w.act!
  end
end
