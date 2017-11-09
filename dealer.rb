require './players.rb'

class Dealer < Players
  # include Mehanika

  def initialize(name = 'Dealer')
    super
  end

  def dealer_choice
    # p 'Dealer_choice'
    dealer = @@players['Dealer']
    # p "dealer = #{dealer}"
    dealer_cards = dealer.instance_variable_get(:@cards)
    # p dealer_cards
    sum =  cards_sum(dealer_cards)
    # p sum

    # 15 magic
    if sum < 15 && dealer_cards.count < 3 
      key = :yes
    else
      key = :pass
    end
    choice = {yes: proc {dealer.add_more_card}, pass: proc {open_cards}}
    choice[key].call
  end

  
end