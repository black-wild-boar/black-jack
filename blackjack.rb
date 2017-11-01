require './player.rb'
require './dealer.rb'
require './modules/mehanika.rb'


class BlackJack
  
  def self.welcome
    p 'Welcome to BlackJack!'
    p 'Enter your name'
    name = gets.chomp
    p "Hi, #{name}"
  end
  loop do
    welcome
    break if 'exit'
  end
end









# game1 = BlackJack.new