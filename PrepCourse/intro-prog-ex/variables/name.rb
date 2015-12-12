# Asks the user for their name then displays a greeting

# Get the first name
print "Please enter your first name: "
f_name = gets.chomp

# Get the last name
print "Please enter your last name: "
l_name = gets.chomp

10.times do |n|
  puts "Greetings #{f_name} #{l_name}!"
end
