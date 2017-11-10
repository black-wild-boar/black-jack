require './players.rb'

class Dealer < Players

  def initialize(name = 'Dealer')
    super
  end
  
  def choice
    # 15 magic
    if cards_sum < 15 && cards_count < 3 
      key = :yes
    else
      key = :pass
    end
    choice = {yes: proc {get_card}, pass: proc {self.class.open_cards}}
    choice[key].call
  end
end