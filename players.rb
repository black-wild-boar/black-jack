class Players
  @@all_cards = []
  @@players = {}

  FIRST_BET = 10
  WIN_COUNT = 21
  START_CASH = 100
  FIRST_CARDS_COUNT = 2
  MAX_CARDS_COUNT = 3

  def initialize(name, cash = START_CASH)
    @cash = cash
    @name = name
    @cards = []
    show_koloda
    @@bank ||= 0
    first_move
  end

  def show_koloda
    p 'Pack of cards'
    @@all_cards = self.class.koloda
    p @@all_cards
  end

  def first_move
    @@players[self.instance_variable_get(:@name)] = self
    # p "Mehanika first_move #{self}"
    @cash -= FIRST_BET
    @@bank += FIRST_BET
    FIRST_CARDS_COUNT.times do
      add_card
    end
  end

  def add_card
    # p "Mehanika add_card #{self}"
    card = @@all_cards.shuffle.first
    @cards << card
    @@all_cards.delete(card)
  end

  def get_card
    # p "Mehanika get_card #{self}"
    while check_cards_count
      if self.is_a?(Player)
        p 'Get more card, pass or open? yes/pass/open'
        key = gets.chomp.to_sym
        choice = {yes: proc {add_more_card}, pass: proc {dealer_choice}, open: proc {open_cards}}
        choice[key].call
      else
        dealer_choice
      end
    end
  end

  def add_more_card
    add_card
    dealer_choice
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
    # p 'Dealer_choice'
    dealer = @@players['Dealer']
    # p "dealer = #{dealer}"
    dealer_cards = dealer.instance_variable_get(:@cards)
    # p dealer_cards
    sum =  cards_sum(dealer_cards)
    # p sum

    # 15 magic
    if sum < 15 && dealer_cards.count < 3 
      key = :yes
    else
      key = :pass
    end
    choice = {yes: proc {dealer.add_more_card}, pass: proc {open_cards}}
    choice[key].call
  end

  def open_cards
    # p 'Mehanika open_cards'
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
    p 'Who_win?'
    values = []
    players.each do | player |
      values << player.values[0]
    end
    values.keep_if { | value | value <= WIN_COUNT }
    if values.empty?
      p "No winners!"
    elsif values.count(values.max) == 1
      max_value = values.max
      players.select do | player |
        if player.values[0] == max_value
          p "#{player.key(max_value)} win!" 
          get_bank(player)
        end
      end
    else
      p "No winners!"
    end
    @@players.clear
    @@bank = 0
  end

  def get_bank(winner)
    key = winner.keys[0]
    cash = @@players[key].instance_variable_get(:@cash)
    cash += @@bank
    @@players[key].instance_variable_set(:@cash, cash)
    p @@players
  end

  def show_cards
    # p 'Mehanika show_cards'
    #not work
    # p "#{get_name} have #{show_my_cards} cards" if self.class.is_a?(Player)
    # p "#{get_name} have #{'*' * show_my_cards} cards" if self.class.is_a?(Dealer)
    #work
    p "#{get_name} have #{show_my_cards} cards" if self.class.name == 'Player'
    p "#{get_name} have #{'*' * show_my_cards.count} cards" if self.class.name == 'Dealer'
  end

  def show_my_cards
    return self.instance_variable_get(:@cards)
  end

  def get_name
    return self.instance_variable_get(:@name)
  end

  def get_cash
    return self.instance_variable_get(:@cash)
  end

	def self.koloda
    # cards = %w(2 3 4 5 6 7 8 9 10 V D K T)
    cards = %w(2 T)
    # masti in unicode
    @@masti = %w(2660 2663)# 2665 2666)
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
    return sum
  end
end
