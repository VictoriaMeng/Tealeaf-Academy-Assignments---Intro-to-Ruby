attacks = ["Rock", "Paper", "Scissors"]

def say(message)
  puts "=> #{message}"
end

say "Let's play 'Rock, Paper, Scissors'!" 

loop do 
  say "Please select (R/P/S)"
  player_attack = gets.chomp
  opponent_attack = attacks.sample
  
  if player_attack.downcase == "r" || player_attack.downcase == "rock"
    player_attack = "Rock"
  elsif player_attack.downcase == "p" || player_attack.downcase == "paper"
    player_attack = "Paper"
  elsif player_attack.downcase == "s" || player_attack.downcase == "scissors"
    player_attack = "Scissors"
  else 
    say "You can only enter 'R', 'P', or 'S'!"
    redo
  end
  
  say "You play #{player_attack}. Computer plays #{opponent_attack}."
  
  if player_attack == opponent_attack
    say "It's a tie!"
  elsif (player_attack == "Rock") && (opponent_attack == "Scissors") 
    say "You win!"
  elsif (player_attack == "Paper") && (opponent_attack == "Rock") 
    say "You win!" 
  elsif (player_attack == "Scissors") && (opponent_attack == "Paper")
    say "You win!"
  elsif (player_attack == "Rock") && (opponent_attack == "Paper") 
    say "You lose!" 
  elsif (player_attack == "Paper") && (opponent_attack == "Scissors") 
    say "You lose!"
  elsif (player_attack == "Scissors") && (opponent_attack == "Rock") 
    say "You lose!"
  end

    say "Press 'Y' to play again! Press any other key to exit."
    break if gets.chomp.downcase != "y"
end

say "Thanks for playing!"
    
