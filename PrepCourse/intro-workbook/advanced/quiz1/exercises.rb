# Answers to the exercises under advance portion for quiz 1

def separator(name)
  puts name.center(40, "--")
end

# Exercise 1
separator "Ex1"
if false
  greeting = “hello world”
end

p greeting
# There will be an error about an uninitialized variable. The if statement did
# not initialize the greeting variable.
# CORRECT - The if statement initializes the 'greeting' variabe even if it did
# not get executed

# Exercise 2
# The last line display the greetings hash. It prints out the new value. This
# happens because the "informal greeting" variable used the << method. This method
# modifies the object that called it.

# Exercise 3
# A. one is one; two is two; three is three
# B. one is one; two is two; three is three
# C. one is two; two is three; three is one

# Exercise 4
separator "Ex4"
def get_uuid
  hex_chars = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
  uuid = ""
  slots = [8, 4, 4, 4, 12]
  slots.each do |slot|
    slot.times { uuid += hex_chars[rand(16)] }
    uuid += '-'
  end
  uuid.chomp('-')
end
puts get_uuid

# Exercise 5
separator "Ex5"
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  true
end
