a = %w(2 3 4 5 6 7 8 9 10 V D K T)
b = %w(2660 2663 2665 2666)

p a
p b
b.map!{ |x| [x.hex].pack("U") }

new = []

a.each do |x|
	b.each do |y|

new << x + y
end
end


p a
p b
p new
p new.shuffle!

p ["2660".hex].pack("U") #piki
p ["2663".hex].pack("U") #trefi
p ["2665".hex].pack("U") # chervi
p ["2666".hex].pack("U") # bubi

# return ASCII from UNICODE
# p {U/2660}

#ASCII
# &spades; &#9824
# &clubs; &#9827
# &hearts; &#9829
# &diams; &#9830

#UNICODE
# U+2660 .. U+2667
