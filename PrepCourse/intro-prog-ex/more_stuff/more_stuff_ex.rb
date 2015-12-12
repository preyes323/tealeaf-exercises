# Answers to the more_stuff chapter exercise

# Exercise 1
words = ['laboratory', 'experiment', 'Pans Labyrinth', 'elaborate', 'polar bear']

# def check_in(word)
#
# end

words.select { |word| puts "#{word} has 'lab' in it" if word =~ /lab/i }

# Exercise 2
# Nothing will be displayed on the screen since the block wasn't called.

# Exercise 3
# Exception handling is way to handle dangerous operations. It provides a way
# gracefully handly errors and not just abruptly end the program. It also gives
# a way to capture and log errors.

# Exercise 4
def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!"}

# Exercise 5
# There is a missing '&' symbol before the word 'block'. This is needed to
# signify that a block is being passed/received to/by the method
