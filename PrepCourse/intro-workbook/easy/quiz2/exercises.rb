# Answers to the exercises under easy portion for quiz 2

def separator(name)
  puts "----------  #{name}  ----------"
end

# Exercise 1
separator("Ex1")
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

key = "Spot"
ages.fetch(key) { |a| puts "There is no age present for #{a.inspect}" }
if ages.has_key?(key)
  puts ages[key]
else
  puts "There is no age present for #{key.inspect}"
end

if ages.key?(key)
  puts ages[key]
else
  puts "There is no age present for #{key.inspect}"
end

# Exercise 2
separator("Ex2")

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10,
         "Marilyn" => 22, "Spot" => 237 }
total_age = 0
ages.each_value do |v|
  total_age += v
end
p "The total age is #{total_age}."
p "The total age is " + ages.values.inject(:+).to_s + "."

# Exercise 3
separator("Ex3")
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.delete_if { |k, v| v >= 100 }

# Exercise 4
separator("Ex4")
munsters_description = "The Munsters are creepy in a good way."
p munsters_description.capitalize
p munsters_description.swapcase
p munsters_description.downcase
p munsters_description.upcase

# Exercise 5
separator("Ex5")
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

p ages.merge!(additional_ages)

# Exercise 6
separator("Ex6")
p ages.values.sort.first
p ages.values.min

# Exercise 7
separator("Ex7")
advice = "Few things in life are as important as house training your pet dinosaur."
# Search for exact word
p advice.split.include?("Dino")
p advice.include?("Dino")

# Exercise 8
separator("Ex8")
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.index { |name| name.match("Be") }

# Exercise 9-10
separator("Ex9-10")
p flintstones.map{ |name| name[0, 3] }
