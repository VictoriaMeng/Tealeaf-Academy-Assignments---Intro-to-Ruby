module Format
  def say(message)
    puts "--- #{message} ---"
  end
  
end

class Game
  include Format
  
  def initialize
    @deck = Deck.new
    @player = Hand.new("Player")
    @dealer = Hand.new("Dealer")
    full_game(@deck, @player, @dealer)
  end
  
  def setup(deck, player, dealer)
    2.times do
      Card.deal(@deck, @player)
      Card.deal(@deck, @dealer)
    end
    show_hands(player, dealer)
  end
  
  def show_hands(player, dealer)
    p "#{dealer.name} Hand: #{dealer.hand.collect {|card| card[0]}} = #{dealer.hand_total}".tr('"', '')
    p "#{player.name} Hand: #{player.hand.collect {|card| card[0]}} = #{player.hand_total}".tr('"', '')
  end

  def play_again
    say "Press 'Y' to play again! Press any other key to exit."
    @input = gets.chomp
    if @input.downcase == "y" || @input.downcase == "yes"
      game = Game.new
    else 
      puts "Thanks for playing!"
    end
  end
  
  def blackjack_win(player, dealer)
    if player.hand_total == 21
      say "Blackjack! You win!"
      @blackjack_win = "true"
    elsif dealer.hand_total == 21
      say "Dealer gets Blackjack! You lose!"
      @blackjack_win = "true"
    elsif player.hand_total != 21 && dealer.hand_total != 21
      say "No one gets Blackjack. Game continues." 
      @blackjack_win = "false"
    end
  end

  def check_winner(player, dealer)
    show_hands(player, dealer)
    if player.hand_total > dealer.hand_total
      say "You win!"
    else
      player.hand_total <= dealer.hand_total
      say "You lose!"
    end
  end
  
  def player_turn(deck, player, dealer)
    say "Your Turn"
    say "Hit or Stand? (H/S)"
    @input = gets.chomp
    hit_or_stand(deck, player, dealer)
    player.bust_check
    show_hands(player, dealer) if player.bust == "false"
    player_turn(deck, player, dealer) if player.bust == "false" && @stand != "true" 
  end

  def hit_or_stand(deck, player, dealer)
    if @input.downcase == "h" || @input.downcase == "hit"
      Card.deal(deck, player) 
    elsif @input.downcase == "s" || @input.downcase == "stand"
      @stand = "true"
    else
      say "Please enter 'H' for 'Hit', or 'S' for 'Stand'."
      player_turn(deck, player, dealer)
    end
  end

  def dealer_turn(deck, player, dealer)
    say "Dealer Turn"
    until dealer.hand_total >= 17
      show_hands(player, dealer)
      Card.deal(deck, dealer)
    end
    dealer.bust_check
  end
  
  def full_game(deck, player, dealer)
    setup(deck, player, dealer)
    if blackjack_win(player, dealer) == "true"
      play_again
    else
      player_turn(deck, player, dealer)
      dealer_turn(deck, player, dealer) if player.bust == "false"
      check_winner(player, dealer) if dealer.bust == "false" && player.bust == "false"
      play_again
    end
  end
  
end

class Card  
  include Format
  
  attr_accessor :name, :deck, :hand, :card, :hand_total, :bust
  
  def self.deal(deck, hand)
    @card = deck.deck.sample
    deck.deck.delete_at(deck.deck.index(@card))
    hand.hand << @card
    hand.ace_value
    puts "Card dealt: #{@card[0]}."
  end
 
end

class Deck < Card
  include Format
  
  def initialize
    @deck = []
    4.times do 
      for integer in 2..10
        self.deck << [integer, integer]
      end
      self.deck.push(['Jack', 10], ['Queen', 10], ['King', 10], ['Ace(11)', 11])
    end
  end
  
end

class Hand < Card
  include Format
  
  def initialize(name)
    @name = name
    @hand = []
    @bust = "false"
  end
  
  def hand_total
    @hand_total = 0
    @hand.each {|card| @hand_total += card[1]}
    @hand_total
  end
  
  def ace_value
    self.hand[(self.hand.index(['Ace(11)', 11]))] = ['Ace(1)', 1] if hand_total > 21 && self.hand.include?(['Ace(11)', 11])
  end
  
  def bust_check
    if self.hand_total > 21
      p "#{self.name} Hand: #{self.hand.collect {|card| card[0]}} = #{self.hand_total}".tr('"', '')
      say "That's over 21! #{self.name} busted!"
      @bust = "true"
    end
  end

end

game = Game.new
