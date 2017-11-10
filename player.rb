require './players.rb'

class Player < Players
  def choice(key)
    choice = {yes: proc {get_card}, pass: proc {dealer_choice}, open: proc {self.class.open_cards}}
    choice[key].call
  end
end