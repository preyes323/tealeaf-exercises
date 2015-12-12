# Declare the four (4) digit number
NUMBER = 4325

# Get the thousands place
puts NUMBER / 1000

# Get the hundreds place
puts (NUMBER % 1000) / 100

# Get the tens place
puts ((NUMBER % 1000) % 100) / 10

# Get the ones place
puts NUMBER % 1000 % 100 % 10
