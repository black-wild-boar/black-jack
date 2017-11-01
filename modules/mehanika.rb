module Mehanika

  def self.included(mixin_class)
    mixin_class.extend ClassMethods
    mixin_class.send :include, InstanceMethods
  end

  module ClassMethods
    FIRST_BET = 10
    WIN = 21
    START_CASH = 100
    FIRST_CARDS_COUNT = 3
    @@all_cards = w%(6, 7, 8, 9, 10, V, D, K, T)
    masti = w%(ch, b, kr, pik) #ASCII code
    @@bank = 0
  end

  module InstanceMethods
    @cards = {}
    def initialize(name, cash = START_CASH)
      @name = name
      first_hod
    end

    def first_hod
      self.bank -= FIRST_BET
      FIRST_CARDS_COUNT.times {get_card}
    end
    def get_card
      card = all_cards.rnd(1)
      cards << card
      @@all_cards.delete(card)
    end
    def pass
    end
    def set_bet
    end
  end
end