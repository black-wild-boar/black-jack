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


    @@all_cards = [6,7,8,9,10]
    @@bank = 0
    @@card_count = {v: 10, d: 10, k:10, t: 11}

    # @@all_cards = w%(6, 7, 8, 9, 10, V, D, K, T)
    # masti = w%(ch, b, kr, pik) #ASCII code
    attr_accessor :cash, :name, :cards

    def initialize(name, cash = START_CASH)
      @cash = cash
      @name = name
      @cards = []
      first_hod
    end

    def first_hod

      p "#{@name} have #{@cash} money"
      @cash -= FIRST_BET
      p "#{@name} have #{@cash} money"
      p @cards
      FIRST_CARDS_COUNT.times do
        @cards << get_card
      end
    end
    
    def get_card
            p "#{@name} have #{@cash} money"
      card = @@all_cards.shuffle.first
      p "Get card #{card}"
      p "@@all_cards #{@@all_cards}"
      @@all_cards.delete(card)
    end
    def pass
    end
    def set_bet
    end
  end
end