class Deck

  @@all_cards = []
  CARDS = %w(2 3 4 5 6 7 8 9 10 V D K T)
  # masti (convert unicode to ascii)
  MASTI = %w(2660 2663 2665 2666).map!{ |mast| [mast.hex].pack("U") }

  def initialize
    @cards ||= []
  end

  def self.new_deck
    CARDS.each do |card|
      MASTI.each do |mast|
        @@all_cards << card + mast
      end
    end
    p @@all_cards.shuffle!
  end

  def self.show_deck
    p "Deck of cards #{@@all_cards}"
  end

  def add_card
    card = @@all_cards.shuffle.first
    @@all_cards.delete(card)
    @cards << card
  end

  def sum
    pack = @cards
    #delete masti
    MASTI.each do |mast|
      pack.map! { |card| card.delete(mast)}
    end
    #card_sum
    tsifri = 2..10
    v_t = {V: 10, D: 10, K: 10, T: 11}
    sum = 0
    t_count = pack.count('T')
    if t_count > 1
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
    return sum
  end

  def count
    @cards.count
  end

  def show
    @cards
  end
end
