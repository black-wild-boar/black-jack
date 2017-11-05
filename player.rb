# require './modules/mehanika.rb'
require './players.rb'

class Player < Players
  # include Mehanika
  
    def initialize(name, cash = 'START_CASH', cards_count = 0)
      @cash = cash
      @name = name
      @cards = []
      @cards_count = cards_count

      # @@all_cards
    end

  def open_cards
    
  end
end