# calculator.rb
# Very simple calculator app
require 'pry'

def say(msg)
  puts "=> #{msg}"
end


say "What's the first number?"
num1 = gets.chomp

say "What's the second number?"
num2 = gets.chomp

say "Choose your operation: (1) add, (2) subtract, (3) divide, (4) multiply"
operator = gets.chomp


case operator
when '1'
  result = num1.to_i + num2.to_i
when '2'
  result = num1.to_i - num2.to_i
when '3'
  result = num1.to_f / num2.to_f
else '4'
  result = num1.to_i * num2.to_i
end

say "Result is #{result}"
