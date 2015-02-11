module Format
  def say(message)
    puts "=> #{message}"
  end
  
end

module Gameplay
  def player_turn
    say "Place your piece. Empty squares left: #{empty_squares.keys}"
    @input = gets.chomp
    if empty_squares.has_key?(@input.to_i) == false
      say "Make sure you picked an empty square!"
      player_turn
    end
    @board[@input.to_i] = "X"
    draw
    check_state
  end
  
  def opponent_turn
    square = empty_squares.keys.sample
    @board[square] = "O"
    draw
    say "Opponent places a piece at #{square}."
    check_state
  end
  
  def game
    draw
    begin
      player_turn
      break if self.board_state == "Player won!"
      break if self.board_state == "It's a tie!"
      opponent_turn
    end while self.board_state == "continue"
    say "#{self.board_state}"
    play_again
  end 
    
  def play_again
    say "Play again? Enter Y/N"
    input = gets.chomp
    if input.downcase == "y" || input.downcase == "yes"
      initialize
      game
    elsif
      input.downcase == "n" || input.downcase == "no"
      say "Thanks for playing!"
    else
      say "Please enter 'Y' or 'N'!"
      play_again
    end
  end
    
end

class Board
  include Format, Gameplay
  
  attr_accessor :board_state
    
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    @board = {}
    (1..9).each {|square, _| @board[square] = " "}
    @board_state = "continue"
  end
  
  def draw
    system 'clear'
    puts ""
    puts "       |       |       "
    puts "  #{@board[1]}    |   #{@board[2]}   |   #{@board[3]}   "
    puts "       |       |       "
    puts "-------+-------+-------"
    puts "       |       |       "
    puts "  #{@board[4]}    |   #{@board[5]}   |   #{@board[6]}   "
    puts "       |       |       "
    puts "-------+-------+-------"
    puts "       |       |       "
    puts "  #{@board[7]}    |   #{@board[8]}   |   #{@board[9]}   "
    puts "       |       |       "
    puts ""
  end

  def empty_squares
    @board.select {|_, symbol| symbol == " "}
  end

  def check_state
    WINNING_LINES.each do |line|
      if !@board.has_value?(" ") && @board.values_at(*line).count("X") < 3
        self.board_state = "It's a tie!"
      elsif @board.values_at(*line).count("X") >= 3
        self.board_state = "Player won!"
      elsif @board.values_at(*line).count("O") == 3
        self.board_state = "Computer won!"
      end
    end
  end

end

new_game = Board.new
new_game.game
