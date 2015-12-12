# Answers to the exercises under intermediate portion for quiz 1

def separator(name)
  puts name.center(40, "--")
end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

# Exercise 1
separator "Ex1"

tot_age = 0
munsters.select{ |key, value| value["gender"] == "male" }.each do |key, value|
  tot_age += value["age"]
end
p tot_age

# Exercise 2
separator "Ex2"
munsters.each do |name, detail|
  puts "#{name} is a #{detail['age']} year old #{detail['gender']}."
end

# Exercise 3
separator "Ex3"
def tricky_method(a_string_param, an_array_param)
  an_array_param << "rutabaga"
  a_string_param += "rutabaga"

  return an_array_param, a_string_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_array, my_string = tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# Exercise 4
separator "Ex4"
sentence = "Humpty Dumpty sat on a wall."
puts sentence.split(/\W/).reverse!.join(" ")

# Exercise 5
# 42

# Exercise 6
# The hash will be modified. Hashes are pass by reference.

# Exercise 7
# paper

# Exercise 8
# no
