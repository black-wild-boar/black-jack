require './deck.rb'

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
    @cards = Deck.new
    @@players[name] = self
    @@bank ||= 0
  end

  def cards_show
    @cards.show
  end

  def self.show_players
    p @@players
  end

  def first_move
    @cash -= FIRST_BET
    @@bank += FIRST_BET
    FIRST_CARDS_COUNT.times do
      @cards.add_card
    end
  end

  def get_card
    @cards.add_card
    if self.is_a?(Player)
      dealer_choice
    else
      self.class.open_cards
    end
  end

  def cards_sum
    @cards.sum
  end

  def cards_count
    @cards.count
  end

  def cards
    p "#{@name} have #{cards_show} cards" if self.class.name == 'Player'
    p "#{@name} have #{'*' * cards_count} cards" if self.class.name == 'Dealer'
  end

  def self.open_cards
    @@players.each do | name, player |
      cards = player.instance_variable_get(:@cards)
      p "Player #{name} have #{cards.show} cards. #{cards.sum} points"
    end
    who_win?
  end

  def dealer_choice
    @@players['Dealer'].choice
  end

  def self.who_win?
    p 'Who win?'
    rates = []
    players = @@players.values
    players.each do | player |
      cards = player.instance_variable_get(:@cards)
      rates << cards.sum
    end
    rates.keep_if { | value |  value <= WIN_COUNT }
    max = rates.max
    if rates.empty?
      p "No winners!"
    elsif rates.count(max) == 1
      winner_name(max)
    else
      p "No winners!"
    end
  end

  def self.winner_name(sum)
    @@players.each do | name, player |
      cards = player.instance_variable_get(:@cards)
      cash =  player.instance_variable_get(:@cash) + @@bank
      p "#{name} win! #{cash} cash." if cards.sum == sum
    end
    @@players.clear
    @@bank = 0
  end
end
