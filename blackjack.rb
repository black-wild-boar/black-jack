require './player.rb'
require './dealer.rb'

class BlackJack


  
  def self.welcome
    p 'Welcome to BlackJack!'
    p 'Enter your name'
    name = gets.chomp
    p "Hi, #{name}"

    @gamer = Player.new(name)
    @dealer = Dealer.new
    p @gamer
    p @dealer
  end
welcome
  # loop do
  #   welcome
  #   break if 'exit'
  # end

end

# game1 = BlackJack.new
# p BlackJack.constants