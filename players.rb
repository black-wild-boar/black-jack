class Players
  @@all_cards = []
  # @@cards_count = {V: 10, D: 10, K: 10, T: 11}
  # alias pack_of_cards koloda
  @@players = {}

  FIRST_BET = 10
  WIN = 21
  START_CASH = 100
  FIRST_CARDS_COUNT = 2
  MAX_CARDS_COUNT = 3


  @@bank = 0

  # attr_accessor :cash, :name, :cards

  def initialize(name, cash = START_CASH)#, cards_count = 0)
    @cash = cash
    @name = name
    @cards = []
    # @@players[name]
    # @cards_count = cards_count
    show_koloda

    first_move
  end

  def show_koloda
    p 'Pack of cards'
    @@all_cards = self.class.koloda
    p @@all_cards
  end

  def first_move
    @@players[self.instance_variable_get(:@name)] = self
    p 'Mehanika first_move'
    # p "#{@name} have #{@cash} money"
    @cash -= FIRST_BET
    # p "#{@name} have #{@cash} money"
    p "player #{@name} have #{@cards.count} cards"
    FIRST_CARDS_COUNT.times do
      p self
      add_card
    end
    p "first_move #{self}"
  end

  def add_card
    p 'Mehanika add_card'
    p "@@all_cards #{@@all_cards}"
    # if cards.count.zero?

    # p "get_card #{@name} have #{@cash} money 5"
    card = @@all_cards.shuffle.first
    p "Get card #{card}"
    @cards << card
    # p "@@all_cards #{@@all_cards}"
    @@all_cards.delete(card)
  end

  def get_card
    
    p 'Mehanika get_card'
    p self

    p @cards.count < MAX_CARDS_COUNT

    while @cards.count < MAX_CARDS_COUNT
      
      if self.is_a?(Player) 
        p 'Get more card or open? yes/no/open'
        key = gets.chomp.to_sym
      else
        key = :yes
      end
      choice = {yes: add_card, no: '@dealer.choice', open: show_cards}
      choice[key]
    end
  end

  def show_cards
    p 'Mehanika show_cards'
    p @@players.values
    
    players = []
    @@players.each do | k, v |
      name = k
      cards = v.instance_variable_get(:@cards)
      p "#{@name} have #{@cards} cards. Sum #{cards_sum(cards)}"
      players << { k => cards_sum(cards) }
    end
    
    who_win?(players)
  end

  def who_win?(players)
    values = []
    players.each do | player |
      values << player.values[0]
    end
    
    max_value = values.max

    p players

    players.select do | player |
      p "#{player.key(max_value)} win!" if player.values[0] == max_value 
      p "No winners!" if player.values[0] == player.values[1]
    end
  end

# ======
	def self.koloda
    cards = %w(2 V 8)# 3 4 5 6 7 8 9 10 V D K T)
    # masti in unicode
    @@masti = %w(2660 2663 2665 2666)
    # masti in ascii
    @@masti.map!{ |mast| [mast.hex].pack("U") }
    # collect koloda
    cards.each do |card|
      @@masti.each do |mast|
        @@all_cards << card + mast
      end
    end
    @@all_cards.shuffle!
  end
    
  def cards_sum(pack)
    
    #delete masti
    @@masti.each do |mast|
      pack.map! { |card| card.delete(mast)}
    end

    #card_summ
    tsifri = 2..10
    v_t = {V: 10, D: 10, K: 10, T: 11}

    sum = 0
    p pack
    pack.each do |card|
      p "card = #{card}"
      if tsifri.include?(card.to_i)
        p "tsifra = #{card}"
        sum += card.to_i
      else
        sum += v_t[card.to_sym]
        # if (v_t[card.to_sym] == 11 && (sum + v_t[card.to_sym]) > 21  )
      end
      
    end
    return sum
    # p "sum = #{sum}"
    # return cards_sum
  end

end

# p = Players.new
# p.koloda
# p Players.class_variables
# p p.instance_variables

# # masti = Players.class_variable_get(:@@masti)
# cards = Players.class_variable_get(:@@all_cards)
# p.pack_of_cards_count(cards)
