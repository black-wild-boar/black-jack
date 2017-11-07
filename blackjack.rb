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
      p "Hi, #{@player.get_name}! You have #{@player.get_cash} cash and #{@player.show_cards} cards"
      @dealer = Dealer.new
      p "#{@dealer.get_name} have #{@dealer.get_cash} cash and #{@dealer.show_cards} cards"
      p @player
      p @dealer
      game
      p 'One more game? (print "no" if you want to stop game)'
      choice = gets.chomp
      break if choice.strip == 'no'
    end
  end

  def game
    @player.get_card
  end
end

new_game = BlackJack.new
new_game.welcome
