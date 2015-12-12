# inline_exception_example.rb

zero = 0
puts "Before each call"
zero.each { |number| puts number } rescue puts "Can't do that!"
puts "After each call"
