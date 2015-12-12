# Asks the user for their age. Display the age in 10, 20, 30, and 40 yrs after

puts "How old are you?"

# Gets the age and converts it to an integer
age = gets.chomp.to_i

puts "In 10 years you will be #{age + 10}"
puts "In 20 years you will be #{age + 20}"
puts "In 30 years you will be #{age + 30}"
puts "In 40 years you will be #{age + 40}"
