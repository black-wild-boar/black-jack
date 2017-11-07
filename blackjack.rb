require './player.rb'
require './dealer.rb'
# require './koloda.rb'
require './players.rb'

class BlackJack

  def welcome
    p 'Welcome to BlackJack game!'
    loop do
      Players.koloda
      p 'Enter your name'
      name = gets.chomp
      @player = Player.new(name)
      @dealer = Dealer.new
      # p @player
      # p @dealer
      game
      p 'One more game? (print "no" if you want to stop game)'
      choice = gets.chomp
      break if choice.strip == 'no'
    end
  end

private
  def game
    @player.show_cards
    @dealer.show_cards
    @player.get_card
  end
end

new_game = BlackJack.new
new_game.welcome
