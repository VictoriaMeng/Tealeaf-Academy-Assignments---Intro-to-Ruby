module Format
  def say(message)
    puts "=> #{message}"
  end
  
end

class RockPaperScissors
  include Format
  
  attr_reader :attack
  
  @@attacks = ["Rock", "Paper", "Scissors"]
  
  def self.battle(player, opponent)
    if player.attack == "Rock"
      say "It's a tie!" if opponent.attack == "Rock"
      say "You lose!" if opponent.attack == "Paper"
      say "You win!" if opponent.attack == "Scissors"
    elsif player.attack == "Paper"
      say "You win!" if opponent.attack == "Rock"
      say "It's a tie!" if opponent.attack == "Paper"
      say "You lose!" if opponent.attack == "Scissors"
    elsif player.attack == "Scissors"
      say "You lose!" if opponent.attack == "Rock"
      say "You win!" if opponent.attack == "Paper"
      say "It's a tie!" if opponent.attack == "Scissors"
    end 
  end
 
end

class PlayerAttack < RockPaperScissors
  
  def initialize(attack)
    if attack.downcase == "r" || attack.downcase == "rock"
      say "You picked Rock."
      @attack = "Rock"
    elsif attack.downcase == "p" || attack.downcase == "paper"
      say "You picked Paper."
      @attack = "Paper"
    elsif attack.downcase == "s" || attack.downcase == "scissors"
      say "You picked Scissors."
      @attack = "Scissors"
    else
      say "Please enter 'R', 'P', or 'S'."
      input = gets.chomp
      initialize(input)
    end
  end

end

class OpponentAttack < RockPaperScissors
  
  def initialize
    @attack = @@attacks.sample
    say "Opponent picked #{@attack}."
  end
    
end

include Format

begin 
  say "Let's play Rock-Paper-Scissors! Please enter R/P/S."
  input = gets.chomp
  
  player = PlayerAttack.new(input)
  opponent = OpponentAttack.new
  RockPaperScissors.battle(player, opponent)
  
  say "Press 'Q' to quit. Press any other key to play again!"
  play_again = gets.chomp
end while play_again.downcase != "q" 
  
say "Thanks for playing!"
  