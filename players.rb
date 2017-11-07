class Players
  @@all_cards = []
  @@players = {}

  FIRST_BET = 10
  WIN_COUNT = 21
  START_CASH = 100
  FIRST_CARDS_COUNT = 2
  MAX_CARDS_COUNT = 3

  @@bank = 0

  def initialize(name, cash = START_CASH)#, cards_count = 0)
    @cash = cash
    @name = name
    @cards = []
    show_koloda
    first_move
  end

  def show_koloda
    p 'Pack of cards'
    @@all_cards = self.class.koloda
  end

  def first_move
    @@players[self.instance_variable_get(:@name)] = self
    p "Mehanika first_move #{self}"
    @cash -= FIRST_BET
    FIRST_CARDS_COUNT.times do
      add_card
    end
  end

  def add_card
    p "Mehanika add_card #{self}"
    card = @@all_cards.shuffle.first
    @cards << card
    @@all_cards.delete(card)
  end

  def get_card
    p "Mehanika get_card #{self}"
    while check_cards_count
      p check_cards_count.inspect
      p @cards.count
      if self.is_a?(Player)
        p 'Get more card or open? yes/no/open'
        key = gets.chomp.to_sym
        choice = {yes: proc {add_card}, no: proc {dealer_choice}, open: proc {open_cards}}
        choice[key].call
      else
        dealer_choice
      end
    end
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

  def dealer_choice
    p 'dealer_choice'
    @@players['Dealer'].add_card
    open_cards
  end

  def open_cards
    p 'Mehanika open_cards'
    players = []
    @@players.each do | k, v |
      cards = v.instance_variable_get(:@cards)
      sum = cards_sum(cards)
      p "#{k} have #{cards} cards. Sum #{sum}"
      players << { k => sum }
    end
    who_win?(players)
  end

  def who_win?(players)
    p 'who_win?'
    values = []
    players.each do | player |
      values << player.values[0]
    end
    
    while values.max > WIN_COUNT do
      p "max_value = #{max_value}"
      max_value = values.max
      values.delete(max_value) if max_value <= WIN_COUNT
    end

    if values.count(max_value) != values.count
      players.select do | player |
          p "#{player.key(max_value)} win!" if player.values[0] == max_value 
      end
    else
      p "No winners!"
    end
    p @@players
    @@players.clear
    p @@players
  end

  def show_cards
    self.instance_variable_get(:@cards)
  end

  def get_name
    self.instance_variable_get(:@name)
  end

  def get_cash
    self.instance_variable_get(:@cash)
  end

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
      if tsifri.include?(card.to_i)
        sum += card.to_i
      else
        sum += v_t[card.to_sym]
        # if (v_t[card.to_sym] == 11 && (sum + v_t[card.to_sym]) > 21  )
      end
    end
    return sum
  end
end
