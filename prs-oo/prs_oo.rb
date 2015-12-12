require 'pry'

module PrsPlayable
  attr_accessor :hand

  def human_move
    begin
      puts "Choose one:"
      PaperRockScissors::CHOICES.each { |k, v| puts "#{k}: #{v}" }
      print "=> "
      choice = gets.chomp.downcase.to_sym
    end until PaperRockScissors::CHOICES.keys.include?(choice)
    self.hand = Hand.new(choice)
  end

  def ai_move
    self.hand = Hand.new(PaperRockScissors::CHOICES.keys.sample)
  end
end

class Player
  include PrsPlayable

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

class Hand
  include Comparable
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(another_hand)
    return 0 if @value == another_hand.value
    case @value
    when :p
      another_hand.value == :r ? 1 : -1
    when :r
      another_hand.value == :s ? 1 : -1
    when :s
      another_hand.value == :p ? 1 : -1
    end
  end

  def to_s
    PaperRockScissors::CHOICES[value]
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

class PaperRockScissors < Game
  CHOICES = { p: "Paper", r: "Rock", s: "Scissors" }
  # This game is always played against the computer
  def initialize
    super
    add_computer("R2D2")
  end

  def compare_hands
    player = players.select { |player| player.type == "HUMAN" }.first
    computer = players.select { |player| player.type == "AI" }.first
    puts "#{player.name}: #{player.hand} VS #{computer.name}: #{computer.hand}"
    if player.hand == computer.hand
      nil
    elsif player.hand > computer.hand
      player
    else
      computer
    end
  end

  def add_score(winner)
    winner.score += 1
  end

  def display_winner(winner)
    puts "#{winner.name} wins!"
    case winner.hand.value
    when :r then puts "Rock smashes Scissors"
    when :p then puts "Paper smothers Rock"
    else puts "Scissors cuts Paper"
    end
  end

  def play
    add_player
    display_intro("Paper, Rock, and Scissors")
    sleep(2)
    begin
      system "clear"
      display_scores
      players.each { |player| player.move }
      winner = compare_hands
      if winner
        add_score winner
        display_winner winner
      else
        puts "Tie Game!"
      end
      puts "Do you want to play another round (y/n)?"
      display_prompt
      ans = gets.chomp.downcase
    end until ans == 'n'
    puts "Thanks for playing!"
  end
end

PaperRockScissors.new.play
