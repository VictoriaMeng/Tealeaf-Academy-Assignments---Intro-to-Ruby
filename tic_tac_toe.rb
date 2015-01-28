def say(message)
  puts "=> #{message}"
end

def start_board
  board = {}
  (1..9).each {|square| board[square] = " "}
  board
end

def draw_board(board)
  system 'clear'
  puts ""
  puts "       |       |       "
  puts "  #{board[1]}    |   #{board[2]}   |   #{board[3]}   "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "  #{board[4]}    |   #{board[5]}   |   #{board[6]}   "
  puts "       |       |       "
  puts "-------+-------+-------"
  puts "       |       |       "
  puts "  #{board[7]}    |   #{board[8]}   |   #{board[9]}   "
  puts "       |       |       "
  puts ""
end

def blank_spaces(board)
  board.keys.select {|square| board[square] == " "}
end

def player_turn(board)
  begin 
  say "Your symbol is 'X'. Press (1..9) to place a piece."
  say "Make sure you choose a blank space!"
  square = gets.chomp
  end until blank_spaces(board).include?(square.to_i)
  board[square.to_i] = "X"
end

def computer_turn(board)
    say "Opponent places a piece."
    board[blank_spaces(board).sample] = "O"
end

def result(board)
  winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  winning_lines.each do |line|
    if board.values_at(*line).count('X') == 3
      return "Player won!"
    elsif board.values_at(*line).count('O') == 3
      return "Computer won!"
    end
  end
  if blank_spaces(board) == []
    return "It's a tie!"
  end
  nil
end

def announce_result(result)
  say "#{result}"
end

board = start_board
draw_board(board)
begin 
  player_turn(board)
  draw_board(board)
  result = result(board)
  computer_turn(board)
  draw_board(board)
  result = result(board)
end until result
announce_result(result)






