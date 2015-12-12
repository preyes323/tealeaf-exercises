require 'pry'

module BlackjackPlayable
  attr_accessor :money, :bets, :hands
  attr_reader

  def add_hand(hand)
    self.hands ? self.hands << hand : self.hands = [hand]
  end

  def human_move(options = {})
    deck = options[:choices]
    table = options[:table]
    hands.each do |hand|
      until hand.bust?
        puts "#{name}: stay (s) or hit (h)"
        print "=> "
        move = gets.chomp.downcase
        next unless %w(s h).include?(move)
        move == 'h' ? (hand.cards << deck.deal_one; table.call) : break
      end
    end
  end

  def ai_move(options = {})
    deck = options[:choices]
    table = options[:table]
    hands.each do |hand|
      while hand.calculate_total < 17 && !hand.bust?
        hand.cards << deck.deal_one
        table.call
      end
    end
  end
end

class Player
  include BlackjackPlayable

  attr_accessor :score
  attr_reader :name
  attr_reader :type
  attr_reader :role

  def initialize(name, type, role = "Player")
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
      self.type == "AI" ? ai_move(options) : human_move(options)
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

class Card
  attr_reader :suit, :face_value
  SUITS = { 'H' => "♥", 'S' => "♠",
            'D' => "♦", 'C' => "♣" }

  def initialize(suit, face_value)
    @suit = suit
    @face_value = face_value
  end

  def to_s
    "#{face_value}#{SUITS[suit]}"
  end
end

class Deck
  attr_reader :cards

  def initialize(num_decks = 1)
    @cards = []
    %w(H S D C).each do |suit|
      %w(2 3 4 5 6 7 8 9 10 J Q K A).each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    @cards *= num_decks
    mix!
  end

  def deal_one
    cards.pop
  end

  def mix!
    cards.shuffle!
  end

  def num_cards
    cards.size
  end

  def list_cards
    cards.each { |card| puts card }
  end
end

class Hand
  include Comparable
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def calculate_total
    total = cards.collect do |card|
      case card.face_value
      when '2'..'10'
        card.face_value.to_i
      when 'J', 'Q', 'K'
        10
      else
        0
      end
    end.reduce(:+)
    cards.each do |card|
      if card.face_value == 'A'
        if (total + 11) > 21
          total += 1
        else
          total += 11
        end
      end
    end
    total
  end

  def bust?
    calculate_total > 21
  end

  def <=>(another_hand)
    if bust? && another_hand.bust?
      return 0
    elsif bust? && !another_hand.bust?
      return -1
    elsif !bust? && another_hand.bust?
      return 1
    end
    hand_value = calculate_total
    another_hand_value = another_hand.calculate_total
    return 0 if hand_value == another_hand_value
    hand_value > another_hand_value ? 1 : -1
  end

  def to_s
    hand = ""
    cards.each do |card|
      hand += card.equal?(cards.last) ? "#{card}" : "#{card}, "
    end
    hand
  end
end

class BlackjackGame < Game
  attr_accessor :deck, :winners, :game_hands
  attr_reader :difficulty, :num_players

  MAX_CARDS_PLAYER = 6
  MAX_PLAYERS = 4
  ROLES = { 'p' => "Player", 'd' => "Dealer" }
  DIFFICULTIES = { 'b' => 1, 'e' => 3, 'p' => 7 }
  TYPES = { 'h' => "HUMAN", 'a' => "AI" }
  AI_NAMES = { 0 => "C3P0", 1 => "HAL", 2 => "Zero", 3 => "Skynet", 4 => "Zed" }

  def initialize
    super
    add_computer("R2D2")
  end

  def get_difficulty
    begin
      puts("Choose your level - beginner (b), expert (e)" +
           " or professional (p):")
      display_prompt
      ans = gets.chomp.downcase
    end until DIFFICULTIES.keys.include?(ans)
    DIFFICULTIES[ans]
  end

  def add_computer(n, role = "d")
    players << Player.new(n, "AI", ROLES[role])
  end

  def populate_players
    player_types = get_types
    num_players.times do |num|
      if player_types[num] == 'a'
        add_computer(AI_NAMES[num], 'p')
      else
        add_player
      end
    end
  end

  def game_setup
    system "clear"
    display_intro("Black Jack")
    puts "This game is best played with an 80x24 terminal window."
    @num_players = get_num_players
    populate_players
    @difficulty = get_difficulty
    shuffle_deck
  end

  def players_buy_in
    game_players.each do |player|
      if player.type == TYPES['a']
        player.money = 1000
      else
        player.money = get_money_for("buy-in", player)
      end
    end
  end

  def shuffle_deck
    self.deck = Deck.new(difficulty)
  end

  def deal_cards
    get_hands
    players.each_with_index { |player, idx| player.add_hand(game_hands[idx]) }
  end

  def players_bet
    game_players.each do |player|
      player.hands.each_with_index do |_, idx|
        player.bets ||= []
        player.bets[idx] ||= 0
        if player.type == TYPES['a']
          player.bets[idx] += Integer(player.money * (Random.rand(20) / 100.0))
          player.bets[idx] = 5 if player.bets[idx] == 0
        else
          puts "Available: #{player.money}"
          player.bets[idx] += get_money_for("bet", player)
        end
      end
    end
  end

  def show_dealer_hand(reveal = false)
    position_hand("#{dealer.name}", 'Dealer')
    print_divider("Dealer")
    if reveal
      dealer.hands.each { |hand|  position_hand("#{hand}") }
    else
      position_hand("#:#, #{dealer.hands.first.cards[1]}", "Dealer")
    end
    print_divider("Dealer")
  end

  def show_players_hands
    print_divider("Player")
    print_player_names
    print_divider("Player")
    print_players_hand
    print_divider("Player")
  end

  def show_money
    print_money_header
    print_players_money
  end

  def deduct_bet
    game_players.each do |player|
      player.bets.each do |bet|
        player.money -= bet
      end
    end
  end

  def show_table
    system "clear"
    show_dealer_hand
    show_players_hands
    show_money
  end

  def push?
    dealer.hands.first.calculate_total == 21
  end

  def compare_hands
    dealer.hands.each do |dealer_hand|
      game_players.each do |player|
        self.winners[player.name] = []
        player.hands.each do |player_hand|
          if dealer_hand == player_hand
            self.winners[player.name] << "Tie"
          elsif dealer_hand > player_hand
            self.winners[player.name] << dealer
          else
            self.winners[player.name] << player
          end
        end
      end
    end
  end

  def display_winners
    system "clear"
    print "#{dealer.name}'s cards (dealer): #{dealer.hands.first} "
    puts "(#{dealer.hands.first.calculate_total})"
    game_players.each do |player|
      puts "#{player.name}:"
      puts "-=-=-=-=-=-=-"
      player.hands.each_with_index do |hand, idx|
        print "Hand#{idx + 1}: #{hand} (#{hand.calculate_total}) => "
        (puts "Tie Game!"; next) if winners[player.name][idx] == "Tie"
        puts "#{winners[player.name][idx]} wins!"
      end
      puts "-=-=-=-=-=-=-"
    end
  end

  def payout
    game_players.each do |player|
      player.bets.each_with_index do |bet, idx|
        player.money += bet * 2 if winners[player.name][idx].to_s == player.name
        player.money += bet if winners[player.name][idx].to_s == "Tie"
      end
    end
  end

  def initialize_game
    self.winners = {}
    self.game_hands = []
    players.each { |player| player.hands = []; player.bets = [] }
  end

  def players_move
    game_players.each do |player|
      player.move( { choices: deck, table: method(:show_table) })
    end
  end

  def dealer_move
    dealer.move( { choices: deck, table: method(:show_table) })
  end

  def blackjack_on_hole_card?
    dealer.hands.first.calculate_total == 21
  end

  def play_again?
    loop do
      puts "Another hand? (y/n)"
      display_prompt
      ans = gets.chomp.downcase
      return ans == 'y' if %w(y n).include?(ans)
    end
  end

  def play
    game_setup
    players_buy_in

    loop do
      initialize_game
      shuffle_deck if deck.num_cards < players.size * MAX_CARDS_PLAYER
      deal_cards
      players_bet
      deduct_bet
      show_table
      if !blackjack_on_hole_card?
        players_move
        dealer_move
      end
      compare_hands
      display_winners
      payout
      (puts "No more players with money"; break) if no_players_remaining?
      break unless play_again?
    end
    puts "Thanks for playing!"
  end

  private

    def no_players_remaining?
      game_players.select{|player| player.money > 0}.size == 0
    end

    def numeric?(num)
      !!Float(num) rescue false
    end

    def get_hands
      players.size.times { self.game_hands << Hand.new }
      2.times do
        game_hands.each { |hand| hand.cards << deck.deal_one }
      end
    end

    def get_money_for(choice, player)
      valid_money = false
      begin
        puts "How much money do you want to #{choice}, #{player.name}?"
        display_prompt
        money = gets.chomp
        if numeric?(money) && Float(money) > 0
          valid_money = true
          if choice == "bet" && Float(money) > player.money
            puts "Not enough money"
            valid_money = false
          end
        end
      end until valid_money
      Float(money)
    end

    def dealer
      players.first
    end

    def game_players
      players.select { |player| player.role == ROLES['p'] }
    end

    def get_num_players
      begin
        puts "How many players will play (max #{MAX_PLAYERS}) against the dealer?"
        display_prompt
        num = gets.chomp
      end until numeric?(num) && Integer(num) > 0 && Integer(num) <= MAX_PLAYERS
      Integer(num)
    end

    def get_types
      loop do
        puts "Please choose whether a player will be HUMAN (h) or AI (a):"
        puts "NOTE: At least one should be HUMAN (h)"
        dif_types = []
        num_players.times do |num|
          begin
            display_prompt
            dif_types[num] = gets.chomp.downcase
          end until TYPES.keys.include?(dif_types[num])
        end
        return dif_types if dif_types.any? { |type| type == 'h' }
      end
    end

    def position_hand(txt, role)
      if role == ROLES['d']
        print txt.center(80)
      else
        print txt.center(80 / num_players)
      end
    end

    def print_divider(role)
      if role == ROLES['d']
        position_hand("------------", role)
      else
        num_players.times do |offset|
          position_hand("------------", role)
        end
      end
      print "\n"
    end

    def print_player_names
      game_players.each do |player|
        position_hand("#{player.name}", "Player")
      end
      print "\n"
    end

    def print_money_header
      num_players.times do |pos|
        position_hand("Money: #{players[pos + 1].money}", "Player")
      end
      print "\n"
    end

    def print_players_hand
      hand2_exists = false
      num_players.times do |pos|
        position_hand("Hand1 (#{players[pos + 1].hands[0].calculate_total})",
                      "Player")
      end
      print "\n"
      game_players.each do |player|
        player.hands.each_with_index do |hand, idx|
          position_hand("#{hand}", "Player") if idx == 0
          hand2_exists = true if idx == 1
        end
      end
      print "\n"
      if hand2_exists
        num_players.times do |pos|
          position_hand("Hand2 (#{players[pos + 1].hands[0].calculate_total})",
                        "Player")
        end
        print "\n"
        game_players.each do |player|
          player.hands.each_with_index do |hand, idx|
            position_hand("#{hand}", "Player") if idx == 1
          end
        end
        print "\n"
      end
    end

    def print_players_money
      bet2_exists = false
      num_players.times { position_hand("Bet1", "Player") }
      print "\n"
      game_players.each do |player|
        player.bets.each_with_index do |bet, idx|
          position_hand("#{bet}", "Player") if idx == 0
          bet2_exists = true if idx == 1
        end
      end
      print "\n"
      if bet2_exists
        num_players.times { position_hand("Bet2", "Player") }
        print "\n"
        game_players.each do |player|
          player.bets.each_with_index do |bet, idx|
            position_hand("#{bet}", "Player") if idx == 1
          end
        end
        print "\n"
      end
    end
end


game = BlackjackGame.new.play
