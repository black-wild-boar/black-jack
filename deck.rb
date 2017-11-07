class Deck

  @all_cards = []
  # @cards

  # def initialize
  #   @cards << get_card
  #
  # end

  # def get_card
  #   card = @@all_cards.shuffle.first
  #   @@all_cards.delete(card)
  #   return card
  # end

  def self.add_card(player)
    # p self
    Deck.show_deck
    player_cards = player.instance_variable_get(:@cards)
    # p "Mehanika add_card #{self}"
    card = @all_cards.shuffle.first
    @all_cards.delete(card)
    p card
    player_cards << card
    Deck.show_deck
    player.instance_variable_set(:@cards, player_cards)
  end

  # def player_deck
  #   ['player_deck']
  # end

  def self.new_deck
    # cards = %w(2 3 4 5 6 7 8 9 10 V D K T)
    cards = %w(2 T)
    # masti in unicode
    @masti = %w(2660 2663)# 2665 2666)
    # masti in ascii
    @masti.map!{ |mast| [mast.hex].pack("U") }
    # collect koloda
    cards.each do |card|
      @masti.each do |mast|
        @all_cards << card + mast
      end
    end
    @all_cards.shuffle!
  end

  def self.cards_sum(player)
    p player
    pack = get_player_deck(player)
    #delete masti
    @masti.each do |mast|
      pack.map! { |card| card.delete(mast)}
    end
    #card_summ
    tsifri = 2..10
    v_t = {V: 10, D: 10, K: 10, T: 11}
    sum = 0
    t_count = pack.count('T')
    if t_count > 1
      p "pack.uniq = #{pack.uniq}"
      pack = pack.uniq
# if T * 3            
      (t_count-1).times { sum += 1 }
    end
    pack.each do |card|
      if tsifri.include?(card.to_i)
        sum += card.to_i
      else
        sum += v_t[card.to_sym]
      end
    end
    # return sum
    p sum
  end

  def check_cards_count
    if @@players.empty?
      key = false
    else      
      key = true
      @@players.values.each do | value |
        key = false if value.instance_variable_get(:@cards).count == MAX_CARDS_COUNT
      end
    end
    return key
  end


  def self.get_player_deck(player)
    return player.instance_variable_get(:@cards)
  end

  def self.show_deck
    p @all_cards
  end

  def self.wipe_deck
    @all_cards.clear
  end
end

class X
  def initialize
    @cards = []
  end
end

# x = X.new
# p x
# Deck.new_deck
# Deck.add_card(x)
# p x
# p Deck.instance_variables