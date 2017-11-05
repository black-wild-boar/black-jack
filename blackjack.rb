require './player.rb'
require './dealer.rb'
# require './koloda.rb'
require './players.rb'

class BlackJack

  def initialize
    # @koloda = Koloda.new
    # p @koloda
    # p @@all_cards
  end

  def welcome
    p 'Welcome to BlackJack game!'
    @@koloda = Players.new.koloda
    p 'Enter your name'
    name = gets.chomp

    @player = Player.new(name)
    # p "Hi, #{name}! You have #{@player.get_cash} cash and #{player_cards} cards"

    @dealer = Dealer.new
    
    p @player
    p @dealer
    
    p @@koloda
    # game
  end

  def game
    p 'BJ game'
    player_cards
    # p "#{player_cards} cards"
    # p "Dealer have #{ '*' * dealer_cards } cards"
    # p @dealer.show_cards
    # p '55555'
    
    # dealer_cards
    @player.get_card
    p 'back to BJ game'
    player_cards

  end

private
  def player_cards
    p 'BJ player_cards'
# show_cards
    @player.show_cards
    # @dealer.show_cards
  end

  def dealer_cards
    p 'BJ dealer_cards'
    return @dealer.cards.count
  end

  # def show_all_cards
  #   p 'BJ show_all_cards'
  #   player_cards
  #   dealer_cards

  #   # winner(@dealer, @player)
  #   p 'One more game? (yes/no)'
  #   choice = gets.chomp
  #   if choice == 'yes'
  #     welcome
  #   else
  #     p 'See you next time!'
  #   end
  # end


#   def get_card
# choice = {yes: @player.get_card, no: '@dealer.choice', open: show_all_cards}    
#     # while @player.cards.count > 3 do
#     # loop do |variable|
#       p @player.cards.count
      

#       p 'Get more card or open? yes/no/open'
#       choice[gets.chomp.to_sym]
      
#         # p "Wrong choice!"

#         # winner        
#   end
end

new_game = BlackJack.new
new_game.welcome
