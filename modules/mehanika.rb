module Mehanika

  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods

  end

  module InstanceMethods
    FIRST_BET = 10
    WIN = 21
    START_CASH = 100
    FIRST_CARDS_COUNT = 2
    MAX_CARDS_COUNT = 3


    @@all_cards = [1,6,7,8,9,10]
    @@bank = 0
    # @@card_count = {v: 10, d: 10, k:10, t: 11}

    # @@all_cards = w%(6, 7, 8, 9, 10, V, D, K, T)
    # masti = w%(ch, b, kr, pik) #ASCII code
    # attr_accessor :cash, :name, :cards

    def initialize(name, cash = START_CASH, cards_count = 0)
      @cash = cash
      @name = name
      @cards = []
      @cards_count = cards_count
      first_move
    end

    def first_move
      p 'Mehanika first_move'
      # p "#{@name} have #{@cash} money"
      @cash -= FIRST_BET
      # p "#{@name} have #{@cash} money"
      p "player #{@name} have #{@cards} cards"
      FIRST_CARDS_COUNT.times do
        p self
        add_card
      end
      p "first_move #{self}"
    end
    
    def add_card
      p 'Mehanika add_card'
      p "@@all_cards #{@@all_cards}"
      # if cards.count.zero?

      # p "get_card #{@name} have #{@cash} money 5"
      card = @@all_cards.shuffle.first
      p "Get card #{card}"
      @cards << card
      # p "@@all_cards #{@@all_cards}"
      @@all_cards.delete(card)
    end

    def get_card
      
      p 'Mehanika get_card'
      p self
      p "@cards.count #{@cards.count} 1"

      p @cards.count < MAX_CARDS_COUNT

      while @cards.count < MAX_CARDS_COUNT
      # while @cards.count > MAX_CARDS_COUNT do
        
        # p " @player.cards.count #{@player.cards.count}"
        p "@cards.count #{@cards.count} 2"
        p 'Get more card or open? yes/no/open'
        key = gets.chomp.to_sym
        choice = {yes: add_card, no: '@dealer.choice', open: show_cards}

        choice[key]


        # p "get_card #{@name} have #{@cash} money 5"
        # card = @@all_cards.shuffle.first
        # p "Get card #{card}"
        # @cards << card
        # p "@@all_cards #{@@all_cards} 5"
        # @@all_cards.delete(card)
      end
      p "#{@name} have #{@cards.count} cards! 3"
      # who_win?      
    end
    
    def pass
    end
    
    def set_bet
    end

    def get_cash
      return @cash
    end

    def show_cards
      p 'Mehanika show_cards'
      p self
      p self.class
      p "#{@name} have #{@cards} cards" if self.class.is_a?(Player)
      p "#{@name} have #{'*' * @cards.count} cards" if self.class.is_a?(Dealer)
    end

    def calc_cards_count
      cards_count = @cards.inject(0) { |sum, x| sum + x }
    end

  end
end