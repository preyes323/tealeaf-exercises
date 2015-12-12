require 'pry'
module TttPlayable
  def human_move(choices)
    begin
      puts "Available postions: #{choices.inspect}"
      puts "Pick a postion to put your marker (X): "
      print "=> "
      move = gets.chomp.to_i
    end until choices.include? move
    move
  end

  def ai_move(choices)
    choices.sample
  end

end

class Player
  include TttPlayable

  attr_accessor :score
  attr_reader :name
  attr_reader :type
  attr_reader :role

  def initialize(name, type, role = "player")
    @name = name
    @type = type
    @score = 0
    @role = role
  end

  def to_s
    "#{name}"
  end

  def move(options = {})
    if options.has_key? :choices
      self.type == "AI" ? ai_move(options[:choices]) : human_move(options[:choices])
    else
      self.type == "AI" ? ai_move : human_move
    end
  end

end

class Game
  attr_accessor :players

  def initialize
    @players = []
  end

  def add_player
    players << Player.new(get_player_name, "HUMAN")
  end

  def add_computer(n)
    players << Player.new(n, "AI")
  end

  def list_players
    players.each_with_index { |player, index| puts "#{index + 1}: #{player}" }
  end

  def display_intro(game)
    system "clear"
    puts "Welcome to the #{game} Game"
    puts "Good luck playing against the computer!"
  end

  def display_scores
    puts "Scores".center(10, "-")
    players.each { |player| puts "#{player.name}: #{player.score}"}
    puts "-" * 10
  end

  def randomize!
    players.shuffle!
  end

  private

    def get_player_name
      begin
        puts "What is your name, player?"
        display_prompt
        name = gets.chomp
      end until name != ""
      name
    end

    def display_prompt
      print "=> "
    end
end

class Board
  attr_reader :board
  attr_reader :dimension

  WINNING_MARKER_COUNT = 3

  def initialize(size = 3)
    @board = []
    @dimension = size
    dimension.times do |row|
      @board[row] = []
      dimension.times { @board[row] << Squares.new(' ') }
    end
  end

  def draw
    dimension.times do |row|
      print_blank_grid_row(dimension - 1, "   |")
      dimension.times do |column|
        sq = board[row][column]
        sq.occupied? ? marker = sq.to_s : marker = ' '
        column == (dimension - 1) ? puts(" #{marker} ") : print(" #{marker} |")
      end
      print_blank_grid_row(dimension - 1, "   |")
      print_row_separator(dimension) unless row == (dimension - 1)
    end
  end

  def all_squares_marked?
    empty_positions.size == 0
  end

  def empty_positions
    positions = []
    board.flatten.each_with_index do |sq, index|
      positions << index + 1 if !sq.occupied?
    end
    positions
  end

  def place_move(position, marker)
    dimension.times do |row|
      dimension.times do |column|
        if (row + column + 1 + (row * (dimension - 1))) ==  position
          board[row][column].mark = marker
        end
      end
    end
  end

  def marker_wins?(marker)
    (winning_row?(marker) || winning_column?(marker) ||
      winning_diagonal?(marker))
  end

  def winning_row?(marker)
    dimension.times do |row|
      marker_count = 0
      dimension.times do |column|
        if board[row][column].to_s == marker
          marker_count += 1
        else
          marker_count = 0
        end
        return true if marker_count >= WINNING_MARKER_COUNT
      end
    end
    false
  end

  def winning_column?(marker)
    dimension.times do |column|
      marker_count = 0
      dimension.times do |row|
        if board[row][column].to_s == marker
          marker_count += 1
        else
          marker_count = 0
        end
        return true if marker_count >= WINNING_MARKER_COUNT
      end
    end
    false
  end

  def winning_diagonal?(marker)
    dimension.times do |row|
      return false unless (dimension - row) >= WINNING_MARKER_COUNT
      dimension.times do |column|
        if (dimension - column) >= WINNING_MARKER_COUNT
          return true if winning_right_diagonal?(row, column, marker)
        elsif column >= (WINNING_MARKER_COUNT - 1)
          return true if winning_left_diagonal?(row, column, marker)
        end
      end
    end
  end

  private

    def print_blank_grid_row(num_boxes, separator)
      num_boxes.times { print "#{separator}" }
      print "\n"
    end

    def print_row_separator(num_boxes)
      num_boxes.times do |num|
        num == (num_boxes - 1) ? puts("---") : print("---+")
      end
    end

    def winning_right_diagonal?(row, column, marker)
      marker_count = 0
      while column < dimension && row < dimension
        if board[row][column].to_s == marker
          marker_count += 1
        else
          marker_count = 0
        end
        return true if marker_count >= WINNING_MARKER_COUNT
        row += 1
        column += 1
      end
      false
    end

    def winning_left_diagonal?(row, column, marker)
      marker_count = 0
      while column >= 0 && row < dimension
        if board[row][column].to_s == marker
          marker_count += 1
        else
          marker_count = 0
        end
        return true if marker_count >= 3
        row += 1
        column -= 1
      end
      false
    end
end

class Squares
  attr_accessor :mark
  DEFAULT = ' '

  def initialize(marker)
    @mark = marker
  end

  def occupied?
    self.mark != DEFAULT
  end

  def to_s
    mark
  end
end


class TicTacToeGame < Game
  attr_accessor :board
  attr_accessor :board_size

  def initialize
    super
    add_computer("R2D2")
  end

  def get_winner
    if board.marker_wins?('X')
      players.select { |player| player.type == "HUMAN" }
    elsif board.marker_wins?('O')
      players.select { |player| player.type == "AI" }
    else
      nil
    end
  end

  def get_board_size
    puts "What dimension of the board you want to play?: "
    puts "Note: 3 in a row still wins the game."
    begin
      display_prompt
      ans = gets.chomp.downcase
    end until numeric? ans
    ans.to_i
  end

  def game_setup
    add_player
    self.board_size = get_board_size
    self.board = Board.new board_size
    randomize!
    display_intro("TicTacToe")
  end

  def add_score(player)
    player.score += 1
  end

  def play
    game_setup
    sleep(2)
    board.draw
    winner = nil
    loop do
      players.each do |player|
        move = player.move choices: board.empty_positions
        if player.type == "HUMAN"
          board.place_move(move, 'X')
        else
          board.place_move(move, 'O')
          system "clear"
        end
        board.draw
        winner = get_winner
        if winner
          puts "#{player.name} wins!"
          add_score player
          break
        elsif board.all_squares_marked?
          puts "Tie Game!"
          break
        end
      end
      if winner || board.all_squares_marked?
        display_scores
        sleep(2)
        puts "Do you want to play again (y/n):"
        display_prompt
        ans = gets.chomp.downcase
        if ans == 'n'
          break
        else
          self.board = Board.new board_size
          board.draw
        end
      end
    end
  end

  private
    def numeric?(num)
      !!Float(num) rescue false
    end
end

TicTacToeGame.new.play
