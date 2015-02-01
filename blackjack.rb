# Message Format
def say(message)
  puts "=> #{message}"
end

# Instruction Format
def instruct(message)
  puts " --- #{message} --- "
end

# Setting Card Values
card_values = {}
(2..10).each {|card| card_values[card] = card}
  card_values["Jack"] = 10
  card_values["Queen"] = 10
  card_values["King"] = 10
  card_values["Ace(1)"] = 1
  card_values["Ace(11)"] = 11

# Initializing Deck
def initialize_deck 
  deck = []
  4.times do 
    for integer in 2..10 
      deck << integer
    end
    deck.push("Jack", "Queen", "King", "Ace")
  end
  deck
end

# Initializing Starting Hands
player_hand = []
player_hand_values = []
dealer_hand = []
dealer_hand_values = []

# Method to Deal Cards
def deal(deck, card_values, whose_hand, hand_values)
  card = deck.sample
  deck.delete_at(deck.index(card))
  puts "Card dealt: #{card}"
  if card == "Ace"
    instruct "Do you want the Ace to be worth 1 or 11? Enter the value."
    input = gets.chomp
      loop do 
        case input
        when "1"
          whose_hand << "Ace(1)"
          hand_values << 1
          break
        when "11"
          whose_hand << "Ace(11)"
          hand_values << 11
          break
        else 
          say "Enter '1' or '11'."
          input = gets.chomp
        end 
      end
  else 
    whose_hand << card
    hand_values.push(card_values[card])
  end
end

# Method to Count Hand_Total
def hand_total(hand_total, whose_hand, hand_values)
  hand_total = 0
  hand_values.each {|card_value| hand_total += card_value}
  if hand_total > 21 && whose_hand.include?("Ace(11)")
    whose_hand[whose_hand.index("Ace(11)")] = "Ace(1)"
    hand_values[hand_values.index(11)] = 1
  end
    hand_total
end

# Method to Evaluate Results
def result(player_total, dealer_total)
  say "The Dealer's Final Total is ---> #{dealer_total}"
  say "Your Final Total is ---> #{player_total}."
  if dealer_total > 21
    say "Dealer busts! You win!"
  elsif 
    if player_total > dealer_total
      say "You win!"
    elsif player_total < dealer_total
      say "You lose!"
    elsif player_total == dealer_total
      say "Dealer wins tie! You lose!"
    end
  end
end

# Method to Display Hand
def display_hand(name, whose_hand, hand_total)
  say "#{name} Hand: #{whose_hand} --- Total: #{hand_total}"
end
  
# Game Set-Up
deck = initialize_deck

2.times do 
  deal(deck, card_values, player_hand, player_hand_values)
  deal(deck, card_values, dealer_hand, dealer_hand_values)
end

player_total = hand_total(player_total, player_hand, player_hand_values)
dealer_total = hand_total(dealer_total, dealer_hand, dealer_hand_values)
display_hand("Dealer", dealer_hand, dealer_total)
display_hand("Your", player_hand, player_total)

# Checking For Automatic Blackjack Win
if player_total == 21 && dealer_total != 21
  puts "You get Blackjack! You win!"
elsif dealer_total == 21 && player_total != 21
  puts "Dealer gets Blackjack! You lose!"
elsif dealer_total == 21 && player_total == 21
  puts "You both get Blackjack, but Dealer wins tie! You lose!"
else 
  # If No One Gets Blackjack, Your Turn Begins
  begin 
    instruct "Press 'H' to hit. Press 'S' to stand."
    input = gets.chomp
    if input.downcase == "h" || input.downcase == "hit"
      deal(deck, card_values, player_hand, player_hand_values)
      player_total = hand_total(player_total, player_hand, player_hand_values)
      display_hand("Dealer", dealer_hand, dealer_total)
      display_hand("Your", player_hand, player_total)
    elsif input.downcase == "s" || input.downcase == "stand"
      break
    else 
      instruct "Make sure you enter 'H' or 'S'!"
      redo
    end
  end while player_total < 21
    # Dealer's Turn - If You Don't Bust
  if player_total > 21
    puts "That's over 21! You busted! You lose!"
  elsif player_total <= 21 && dealer_total < 17
    instruct "--- Dealer's Turn ---"
    display_hand("Dealer", dealer_hand, dealer_total)
    begin
      deal(deck, card_values, dealer_hand, dealer_hand_values)
      dealer_total = hand_total(dealer_total, dealer_hand, dealer_hand_values)
      display_hand("Dealer", dealer_hand, dealer_total)
    end while dealer_total < 17
    result(player_total, dealer_total)
  elsif player_total <= 21 && dealer_total >= 17
     result(player_total, dealer_total)   
  end
end
    