require 'pry'
# ttt.rb
# My implementation of the tic-tac-toe game. This game is player vs. computer

board = {}
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8],
                 [3, 6, 9], [1, 5, 9], [3, 5, 7]]

def initialize_board(b)
  (1..9).to_a.each { |pos| b[pos] = ' ' }
end

def draw_board(b)
  system "clear"
  puts "   |   |   "
  puts " #{b[1]} | #{b[2]} | #{b[3]} "
  puts "   |   |   "
  puts "---+---+---"
  puts "   |   |   "
  puts " #{b[4]} | #{b[5]} | #{b[6]} "
  puts "   |   |   "
  puts "---+---+---"
  puts "   |   |   "
  puts " #{b[7]} | #{b[8]} | #{b[9]} "
  puts "   |   |   "
end

def empty_positions(b)
  b.select { |k, v| v == ' ' }.keys
end

def player_choice(b)
  valid_pos = empty_positions(b)
  loop do
    puts "Pick a number #{valid_pos}:"
    move = gets.chomp.to_i
    if valid_pos.include?(move)
      b[move] = 'X'
      break
    end
  end
end

def computer_choice(b)
  valid_pos = empty_positions(b)
  move = valid_pos.sample
  b[move] = 'O'
end

def get_winner(b)
  ['X', 'O'].each do |marker|
    WINNING_LINES.each do |line|
      counter = 0
      line.each { |pos| counter += 1 if b[pos] == marker }
      return 'Player' if (counter == 3 && marker == 'X')
      return 'Computer' if (counter == 3 && marker == 'O')
    end
  end
  nil
end

# Main game routine
initialize_board(board)
draw_board(board)

begin
  player_choice(board)
  computer_choice(board)
  draw_board(board)
  winner = get_winner(board)
end until winner || empty_positions(board).empty?

if winner
  puts "#{winner} wins!"
else
  puts "Tie Game!"
end
puts "Thank you for playing!"
