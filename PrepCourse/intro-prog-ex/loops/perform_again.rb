# perform_again.rb

loop do
  puts "Do you want to do that again?"
  answer = gets.chomp.upcase
  break unless answer == 'Y'
end
