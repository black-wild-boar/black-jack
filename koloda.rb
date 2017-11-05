# class Koloda

# 	def initialize
# 		@koloda = bj
# 		p @koloda
# 	end

# 	def bj
#       @@all_cards = []
#       cards = %w(2 3 4 5 6 7 8 9 10 V D K T)
#       # masti in unicode
#       masti = %w(2660 2663 2665 2666)
#       # masti in ascii
#       masti.map!{ |mast| [mast.hex].pack("U") }
#       # collect koloda
#       cards.each do |card|
#         masti.each do |mast|
#           @@all_cards << card + mast
#         end
#       end
#       return @@all_cards.shuffle!
#     end
#     @@cards_count = {V: 10, D: 10, K: 10, T: 11}
# end