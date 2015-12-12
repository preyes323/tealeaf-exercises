# prs.rb
# This my implementation of the 'paper', 'rock', or 'scissors' game
require 'pry'

# Variables
CHOICES = {'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors'}
scores = {'player' => 0, 'computer' => 0, 'tie' => 0}

# Helper methods
def say(msg)
  puts "=> #{msg}"
end

def get_winner(player_choice, computer_choice)
  # Winner from perspective of player
  return 'tie' if player_choice == computer_choice
  winner = case player_choice
           when 'p'
             computer_choice == 'r' ? 'player' : 'computer'
           when 'r'
             computer_choice == 's' ? 'player' : 'computer'
           else
             computer_choice == 'p' ? 'player' : 'computer'
           end
end

def display_result(winner, player_choice, computer_choice)
  say "---"
  if winner == 'tie'
    say "Tie Game! Both select #{CHOICES[player_choice]}"
  else
    say("#{winner.capitalize} wins! Player selected #{CHOICES[player_choice].inspect} " +
        "while computer selected #{CHOICES[computer_choice].inspect}")
  end
end

def update_scores(scores, winner)
  scores[winner] += 1
end

def display_score(scores)
  say "---"
  say "The score is #{scores.inspect}"
  say "---"
end

# Main Program
say "Welcome to the Paper, Rock, or Scissors game."
say "Check how well you can predict the computer's choice."

loop do
  # Get choices
  begin
    say "Choose p, r, or s:"
    player_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(player_choice)
  computer_choice = CHOICES.keys.sample

  # Evaluate choices
  winner = get_winner(player_choice, computer_choice)
  display_result(winner, player_choice, computer_choice)
  update_scores(scores, winner)
  display_score(scores)

  say "Continue playing (y/n)"
  play = gets.chomp.downcase
  break unless play == 'y'
end

say "Thanks for playing!"
