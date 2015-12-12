# doubler.rb
# This program doubles a number until it is equal to or exceeds a certain
# threshold

print "Enter the number that will be doubled: "
number = gets.chomp.to_i
print "Enter the threshold number: "
threshold = gets.chomp.to_i

def doubler(number, threshold)
  puts number
  doubler(number * 2, threshold) if number <= threshold
end

doubler(number, threshold)
