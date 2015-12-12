# Answers to the exercises under intermediate portion for quiz 1

def separator(name)
  puts name.center(40, "--")
end

msg = "The Flintstones Rock!"

# Exercise 1
separator "Ex1"
10.times { |n| puts " " * n + msg }

# Exercise 2
separator "Ex2"
letter_counter = {}
msg.gsub(" ", "").chomp("!").split("").uniq do |letter|
  letter_counter[letter] = msg.scan(letter).count
end
p letter_counter

# Exercise 3
# (40 + 2) is not a string. It can't be concatenated
# use string interpolation or convert to_s

# Exercise 4
# The code will print '1, 3'.
# The code will print '1, 2'.

# Exercise 5
separator "Ex5"
def factors(number)
  dividend = number
  divisors = []
  begin
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  rescue
    puts "Please enter a valid input (any number greater than zero)"
  end until dividend == 0
  divisors
end
# The condition is use the check the number is a divided. A number is a dividend
# if there is no remainder.
# The last line is used to return the output of the method. It made us of an
# implicit return.
p factors(12)

# Exercise 6
# There is no difference in terms of return values. The difference is in the
# impact to the input array/buffer; The first implementation mutates it while t
# second doesn't.

# Exercise 7
separator "Ex7"
# The method does not have access to the limit variable. The limit should also
# be passed as an argument to the method.
limit = 15

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"

# Exercise 8
separator "Ex8"

def titleize(title)
  title = title.split.each{ |word| word.capitalize! }.join(" ")

end
p titleize("paolo reyes's movie")

# Exercise 9
separator "Ex9"
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  case value["age"]
  when 0..17
    value["age_group"] = "kid"
  when 18..64
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end

p munsters
