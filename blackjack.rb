require './player.rb'
require './dealer.rb'
require './players.rb'
require './deck.rb'

class BlackJack

  def welcome
    p 'Welcome to BlackJack game!'
    loop do
      Deck.new_deck
      p 'Enter your name'
      name = gets.chomp
      @player = Player.new(name)
      @dealer = Dealer.new
      game
      p 'Press any key for new game OR print "exit" to stop game'
      choice = gets.chomp
      break if choice.strip == 'exit'
    end
  end

  def first_move
    @player.first_move
    @dealer.first_move
  end

  def game
    first_move
    @player.cards
    @dealer.cards
    get_card?(@player)
  end

  def get_card?(player)
    loop do
      p 'Get more card, pass or open? yes/pass/open'
      choice = %w(yes pass open)
      key = gets.chomp
      if choice.include?(key)
        @player.choice(key.to_sym)
        break
      else
        p 'Wrong choice!'
      end
    end
  end
end

new_game = BlackJack.new
new_game.welcome