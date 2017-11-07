require './player.rb'
require './dealer.rb'
# require './koloda.rb'
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
      p Deck.show_deck
      p @player
      p @dealer
      first_move
      p Deck.show_deck
      # p @player
      # p @dealer
      Deck.cards_sum(@player)
      Deck.cards_sum(@dealer)
      @player.get_card
      
      # game
      p 'Press any key for new game OR print "no" to stop game'
      choice = gets.chomp
      break if choice.strip == 'no'
    end
  end

  def first_move
    @player.first_move
    @dealer.first_move
  end

  def get_card
    if self.is_a?(Player)
      p 'Get more card, pass or open? yes/pass/open'
      key = gets.chomp.to_sym
      choice = {yes: proc {add_more_card}, pass: proc {dealer_choice}, open: proc {open_cards}}
      choice[key].call
    else
      @dealer.get_card
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
