# return.rb

def add_three(number)
  number + 3
end

def just_assignment(number)
  foo = number + 3
end

returned_value = add_three(4)
puts returned_value

returned_value = just_assignment(2)
puts returned_value

add_three(3).times { puts "This should print 6 times" }
