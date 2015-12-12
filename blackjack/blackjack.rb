require 'pry'
# blackjack.rb
# This is my implementation of the procedural blackjack game

### PSEUDO CODE ###
# 1. Player buy in to game
# 2. Shuffle the deck
# 3. Player places bets
# 4. Deal the cards
# 5. Show table
# 6. Dealer checks hole cards if win_on_deal
# 7. Player decides move (stay, hit)
# 8. Dealer decides move
# 9. Determine winner
# 10. Payout

### BONUS ###
# 0. Get users name
# 2. Shuffle 'n' number of decks
# 7. Player decides move (stay, hit, double, split)
# 11. Check if player wants to play again

# CONSTANTS
SUITS = %w(H D C S)
CARDS = %w(2 3 4 5 6 7 8 9 10 J Q K A)
MOVES = [%w(s h), %(s h d)]
DIFFICULTY = %w(b a p)

# HELPERS
def numeric?(num)
  !!Float(num) rescue false
end

def calculate_total(cards)
  total = cards.collect do |card|
    case card[0]
    when '2'..'10'
      card[0].to_i
    when 'J', 'Q', 'K'
      10
    else
      0
    end
  end.reduce(:+)
  cards.each do |card|
    if card[0] == 'A'
      if (total + 11) > 21
        total += 1
      else
        total += 11
      end
    end
  end
  total
end

def bust?(cards)
  calculate_total(cards) > 21
end

# METHODS
def say(msg)
  puts "=> #{msg}"
end

def deal_cards(deck)
  player_cards = []
  dealer_cards = []
  2.times do
    player_cards << deck.pop
    dealer_cards << deck.pop
  end
  return player_cards, dealer_cards
end

def show_table(player_hands, dealer_cards, money, bet, name)
  system "clear"
  say "#{name}'s cards"
  say "---"
  bets = "#{name} bets: "
  player_hands.each do |hand, value|
    say "#{hand}: #{value} : #{calculate_total(value)}"
    say "---"
    bets += " #{hand}: #{bet[hand]}"
  end
  say "Dealer has: #{dealer_cards} : #{calculate_total(dealer_cards)}"
  say "---"
  say bets
  say "#{name} has $#{money} remaining."
  say "---"
end

def shuffle_deck(suits, cards, difficulty)
  deck = []
  case difficulty
  when 'b'
    num_decks = 1
  when 'a'
    num_decks = 4
  else
    num_decks = 8
  end
  num_decks.times { deck += cards.product(suits) }
  deck.shuffle!
end

def get_buy_in
  loop do
    say "How much money do you want to buy-in?"
    money = gets.chomp
    return Float(money) if numeric?(money)
  end
end

def place_bet(money, options = {})
  limit = [money, options.fetch(:existing_money, money)].min
  loop do
    say "How much do you want to bet? (max of $#{limit})"
    bet = gets.chomp
    return Float(bet) if numeric?(bet) && (Float(bet) <= Float(limit))
  end
end

def get_move(player_cards, money, hand)
  begin
    if player_cards.length == 2 && money > 0
      say "#{hand}: Stay(s), Hit(h), or Double(d)"
      valid_moves = MOVES[1]
    else
      say "#{hand}: Stay(s) or Hit(h)"
      valid_moves = MOVES[0]
    end
    move = gets.chomp.downcase
  end until valid_moves.include?(move)
  move
end

def split_hand(player_hands, deck, bets, winner)
  current_cards = player_hands.first.last
  hands = player_hands.length
  key = "hand#{hands+1}".to_sym
  player_hands[key] = []
  bets[key] = bets.first.last
  winner[key] = winner.first.last
  player_hands.each_key do |key|
    player_hands[key] = [current_cards.shift]
    player_hands[key] << deck.pop
  end
end

def dealer_move(player_hands, deck, dealer_cards)
  player_hands.each_key do |hand|
    if !bust?(player_hands[hand])
      while calculate_total(dealer_cards) < 17 && !bust?(dealer_cards)
        dealer_cards << deck.pop
      end
    end
  end
end

def check_hole_card(dealer_cards)
  calculate_total(dealer_cards) == 21 ? "Dealer" : nil
end

def compare_hand(player_cards, dealer_cards)
  return "Dealer" if bust?(player_cards)
  return "Player" if bust?(dealer_cards)
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)
  if dealer_total > player_total
    "Dealer"
  elsif player_total > dealer_total
    "Player"
  else
    "Tie"
  end
end

def payout(winner, money, bet, player_cards)
  if winner == 'Player'
    if calculate_total(player_cards) == 21
      money += bet + (3 * bet / 2.0)
    else
      money += (2 * bet)
    end
  elsif winner == 'Tie'
    money += bet
  else
    money
  end
end

def display_winner(winner, money, hand)
  msg = ""
  case winner
  when "Dealer"
    msg = "You're remaining money is $#{money}"
  when "Player"
    msg = "You now have $#{money}"
  else
    msg = "You're money is still $#{money}"
  end
  say "#{hand}: #{winner} wins!"
  say msg
end

def choose_table
  loop do
    say "Choose your table: Beginner(b), Advance(a), Professional(p)"
    difficulty = gets.chomp.downcase
    return difficulty if DIFFICULTY.include?(difficulty)
  end
end

def player_split?(player_hands, money, bets)
  card1_val = player_hands.first.last.first.first
  card2_val = player_hands.first.last.last.first
  (card1_val == card2_val && money >= bets.first.last)
end

def player_split_option(player_hands, deck, bets, winner)
  begin
    say "Do you want to split your hand? (y/n)"
    move = gets.chomp.downcase
  end until %w(y n).include?(move)
  split_hand(player_hands, deck, bets, winner) if move == 'y'
end

# MAIN APPLICATION
system "clear"
say "Let's Play BLACKJACK!"
say "Hi player! May I get your name please:"
player_name = gets.chomp
say "---"
say ""
say "Welcome #{player_name}!"
difficulty = choose_table
say "Good luck!"
deck = shuffle_deck(SUITS, CARDS, difficulty)
money = get_buy_in
loop do
  player_hands = { hand1: [] }
  bets = { hand1: 0.0 }
  winner = { hand1: '' }
  if deck.length < 20 # Only reshuffle if there are less cards to play a set
    deck = shuffle_deck(SUITS, CARDS, difficulty)
  end
  bets[:hand1] = place_bet(money)
  money -= bets[:hand1]
  player_hands[:hand1], dealer_cards = deal_cards(deck)
  # player_hands[:hand1] = [["J", "S"], ["J", "H"]] # Uncomment to test splitting
  dealer_initial_show = [['#', '#'], dealer_cards.last]
  show_table(player_hands, dealer_initial_show, money, bets, player_name)
  dealer_win = check_hole_card(dealer_cards)
  if !dealer_win
    if player_split?(player_hands, money, bets)
      player_split_option(player_hands, deck, bets, winner)
      money -= bets.fetch(:hand2, 0.0)
      show_table(player_hands, dealer_initial_show, money, bets, player_name)
    end
    player_hands.each_key do |hand|
      loop do
        move = get_move(player_hands[hand], money, hand)
        if move == 'd'
          add_bet = place_bet(bets[hand], { existing_money: money })
          bets[hand] += add_bet
          money -= add_bet
          player_hands[hand] << deck.pop
          show_table(player_hands, dealer_initial_show, money, bets, player_name)
          break
        end
        player_hands[hand] << deck.pop if move == 'h'
        show_table(player_hands, dealer_initial_show, money, bets, player_name)
        break if move == 's' or bust?(player_hands[hand])
      end
    end
    dealer_move(player_hands, deck, dealer_cards)
    show_table(player_hands, dealer_cards, money, bets, player_name)
  else
    say "Dealer got Blackjack!"
  end
  player_hands.each_key do |hand|
    winner[hand] = compare_hand(player_hands[hand], dealer_cards)
    money = payout(winner[hand], money, bets[hand], player_hands[hand])
    display_winner(winner[hand], money, hand)
  end
  if money <= 0.0
    say "Sorry! You ran out of money"
    break
  end
  say "Do you want to play another deal? (y/n)"
  play_again = gets.chomp.downcase
  break if play_again != 'y'
end

say "Thanks for playing!"
