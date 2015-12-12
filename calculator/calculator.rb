# calculator.rb
# This is my version of the simple calculator. The calculator only performs an
# operation two number at a time. However, results can be chained.
require 'pry'
### Helper methods ###
# Method to display a message with a 'Hash Rocket =>'
def say(msg)
  puts "=> #{msg}"
end
# Checks if the user wants to exit the calculator. 'Q' to exit
def exit?(ans)
  ans.upcase == 'Q'
end
# Check if the given string 'num' is a number. Adapted from
# http://rosettacode.org/wiki/Determine_if_a_string_is_numeric#Ruby
def numeric?(num)
  !!Float(num) rescue false
end
# Used to check the user input. Valid input is either "Q" or a number
def get_valid_input(input_type, options = {})
  input = nil
  loop do
    input = gets.chomp
    # binding.pry
    if options.has_key?(:result) && input == ""
      input = options[:result]
      break
    else
      if input_type == "num"
        numeric?(input) || input.upcase == 'Q' ? break : say("Numbers only")
      else
        %w(1 2 3 4 Q).include?(input.upcase) ? break : say("1, 2, 3, or 4 only")
      end
    end
  end
  input
end
# Displays the result of the operation performed on the two numbers
def display_result(num1, num2, operator)
  # say "num1: #{num1}, num2: #{num2}, operator #{operator}"
  case operator
  when '1'
    result = num1.to_i + num2.to_i
    say "#{num1} + #{num2} = #{result}"
  when '2'
    result = num1.to_i - num2.to_i
    say "#{num1} - #{num2} = #{result}"
  when '3'
    begin
      result = num1.to_f / num2.to_f
      say "#{num1} / #{num2} = #{result}"
    rescue
      say("Div by 0")
    end
  else
    result = num1.to_i * num2.to_i
    say "#{num1} * #{num2} = #{result}"
  end
  result.to_s
end

# Main calculator routine
say "Welcome the calculator app."
say "Type 'q' at the prompt, then press (Enter) to exit the calculator."
result = nil
loop do
  if result == nil
    say "Enter the first number:"
    num1 = get_valid_input("num")
  else
    say "Enter the first number(#{result}):"
    num1 = get_valid_input("num", {result: result})
  end
  break if exit?(num1)
  say "Enter the second number:"
  num2 = get_valid_input("num")
  break if exit?(num2)
  say "1) Add, 2) Subrtract, 3) Divide, 4) Multiply"
  operator = get_valid_input("operator")
  break if exit?(operator)
  result = display_result(num1, num2, operator)
end

say "Thank you for using the calculator"
