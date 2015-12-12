# Answer to the loops module exercises

# Exercise 1
x = [1, 2, 3, 4, 5]
x.each do |a|
  a + 1
end
# The starting array is returned

# Exercise 2
loop do
  puts "Enter 'STOP' to exit"
  answer = gets.chomp.upcase
  break if answer == 'STOP'
end

# Exercise 3
arr = ["dog", "cat", "rabbit"]
arr.each_with_index { |item, index| puts "#{index}. #{item}" }

# Exercise 4
def countdown(number)
  puts number
  if number < 1
    number
  else
    countdown(number - 1)
  end
end
countdown(5)
