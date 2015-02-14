module Format
  def say(message)
    puts "--- #{message} ---"
  end
  
end

class Game
  include Format
  
  attr_accessor :main_deck, :player, :dealer
  
  def initialize
    @main_deck = Deck.new
    @player = Hand.new("Player")
    @dealer = Hand.new("Dealer")
    full_game
  end
  
  def setup
    2.times do
      deal(@player)
      deal(@dealer)
    end
    show_hands
  end
  
  def deal(name)
    @card = @main_deck.deck.sample
    @main_deck.deck.delete_at(@main_deck.deck.index(@card))
    name.hand << @card
    name.ace_value
    puts "Card dealt: #{@card[0]}."
  end
  
  def show_hands
    p "#{@dealer.name} Hand: #{@dealer.hand.collect {|card| card[0]}} = #{@dealer.hand_total}".tr('"', '')
    p "#{@player.name} Hand: #{@player.hand.collect {|card| card[0]}} = #{@player.hand_total}".tr('"', '')
  end

  def play_again
    say "Press 'Y' to play again! Press any other key to exit."
    @input = gets.chomp
    if @input.downcase == "y" || @input.downcase == "yes"
      Game.new
    else 
      puts "Thanks for playing!"
    end
  end
  
  def blackjack_win
    if @player.hand_total == 21
      say "Blackjack! You win!"
      true
    elsif @dealer.hand_total == 21
      say "Dealer gets Blackjack! You lose!"
      true
    elsif @player.hand_total != 21 && @dealer.hand_total != 21
      false
    end
  end

  def check_winner
    say "Final Hands"
    show_hands
    if @player.hand_total > @dealer.hand_total
      say "You win!"
    elsif @player.hand_total <= @dealer.hand_total
      say "You lose!"
    end
  end
  
  def player_turn
    say "Your Turn"
    say "Hit or Stand? (H/S)"
    @input = gets.chomp
    hit_or_stand
    @player.bust_check
    show_hands if !@player.bust
    player_turn if !@player.bust && !@stand
  end

  def hit_or_stand
    if @input.downcase == "h" || @input.downcase == "hit"
      deal(@player)
    elsif @input.downcase == "s" || @input.downcase == "stand"
      @stand = true
    else
      say "Please enter 'H' for 'Hit', or 'S' for 'Stand'."
      player_turn
    end
  end

  def dealer_turn
    say "Dealer Turn"
    until @dealer.hand_total >= 17
      show_hands
      deal(@dealer)
    end
    @dealer.bust_check
    puts "Dealer stands." unless @dealer.bust
  end
  
  def full_game
    setup
    if blackjack_win
      play_again
    else
      player_turn
      dealer_turn if !@player.bust
      check_winner if !@dealer.bust && !@player.bust
      play_again
    end
  end
  
end

class Deck
  include Format
  
  attr_accessor :deck, :card, :hand
  
  def initialize
    @deck = []
    4.times do 
      for integer in 2..10
        @deck << [integer, integer]
      end
      @deck.push(['Jack', 10], ['Queen', 10], ['King', 10], ['Ace(11)', 11])
    end
  end
  
end

class Hand
  include Format
  
  attr_accessor :name, :hand, :hand_total, :bust
  
  def initialize(name)
    @name = name
    @hand = []
    @bust = false
  end
  
  def hand_total
    @hand_total = 0
    @hand.each {|card| @hand_total += card[1]}
    @hand_total
  end
  
  def ace_value
    if hand_total > 21 && @hand.include?(['Ace(11)', 11])
      @hand[(@hand.index(['Ace(11)', 11]))] = ['Ace(1)', 1] 
    end
  end
  
  def bust_check
    if hand_total > 21
      p "#{@name} Hand: #{@hand.collect {|card| card[0]}} = #{@hand_total}".tr('"', '')
      say "That's over 21! #{@name} busted!"
      @bust = true
    end
  end

end

Game.new
