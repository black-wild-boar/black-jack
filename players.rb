require './deck.rb'
require './cash.rb'

class Players
  @@players = {}

  FIRST_BET = 10
  WIN_COUNT = 21
  START_CASH = 100
  FIRST_CARDS_COUNT = 2
  MAX_CARDS_COUNT = 3

  def initialize(name, cash = START_CASH)
    @cash = cash
    @name = name
    @cards = []
    @@bank ||= 0
  end
#+
  def first_move
    @@players[self.instance_variable_get(:@name)] = self
    # p "Mehanika first_move #{self}"
    @cash -= FIRST_BET
    @@bank += FIRST_BET
    FIRST_CARDS_COUNT.times do
      Deck.add_card(self)
    end
  end

  def add_more_card
    add_card
    dealer_choice
  end

#+ Deck
  # def check_cards_count
  #   if @@players.empty?
  #     key = false
  #   else      
  #     key = true
  #     @@players.values.each do | value |
  #       key = false if value.instance_variable_get(:@cards).count == MAX_CARDS_COUNT
  #     end
  #   end
  #   return key
  # end

#+ Dealer
  # def dealer_choice
  #   # p 'Dealer_choice'
  #   dealer = @@players['Dealer']
  #   # p "dealer = #{dealer}"
  #   dealer_cards = dealer.instance_variable_get(:@cards)
  #   # p dealer_cards
  #   sum =  cards_sum(dealer_cards)
  #   # p sum

  #   # 15 magic
  #   if sum < 15 && dealer_cards.count < 3 
  #     key = :yes
  #   else
  #     key = :pass
  #   end
  #   choice = {yes: proc {dealer.add_more_card}, pass: proc {open_cards}}
  #   choice[key].call
  # end

  def open_cards
    # p 'Mehanika open_cards'
    players = []
    @@players.each do | k, v |
      cards = v.instance_variable_get(:@cards)
      sum = cards_sum(cards)
      p "#{k} have #{cards} cards. Sum #{sum}"
      players << { k => sum }
    end
    who_win?(players)
  end

  def who_win?(players)
    p 'Who_win?'
    values = []
    players.each do | player |
      values << player.values[0]
    end
    values.keep_if { | value | value <= WIN_COUNT }
    if values.empty?
      p "No winners!"
    elsif values.count(values.max) == 1
      max_value = values.max
      players.select do | player |
        if player.values[0] == max_value
          p "#{player.key(max_value)} win!" 
          get_bank(player)
        end
      end
    else
      p "No winners!"
    end
    @@players.clear
    @@bank = 0
  end

  def get_bank(winner)
    key = winner.keys[0]
    cash = @@players[key].instance_variable_get(:@cash)
    cash += @@bank
    @@players[key].instance_variable_set(:@cash, cash)
    p @@players
  end

  def show_cards
    # p 'Mehanika show_cards'
    #not work
    # p "#{get_name} have #{show_my_cards} cards" if self.class.is_a?(Player)
    # p "#{get_name} have #{'*' * show_my_cards} cards" if self.class.is_a?(Dealer)
    #work
    p "#{get_name} have #{show_my_cards} cards" if self.class.name == 'Player'
    p "#{get_name} have #{'*' * show_my_cards.count} cards" if self.class.name == 'Dealer'
  end

  def show_my_cards
    return self.instance_variable_get(:@cards)
  end

  def get_name
    return self.instance_variable_get(:@name)
  end

  def get_cash
    return self.instance_variable_get(:@cash)
  end
end
