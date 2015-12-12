# Answers to the exercises under easy portion

# Exercise 1
# 1
# 2
# 2
# 3

# Exercise 2
# 1. '!=' is not equal to operator. It is used for comparing two variables.
# 2. '!' negates the current value if before. If value is true, makes it false
# 3. '!' mutates the current value if after.
# 4. '?' before something prints value to screen as a string
# 5. '?' after something typically use to test values and return boolean values
# 6. '!!' is used to turn a value into boolean equivalent

# Exercise 3
advice = "Few things in life are as important as house training your pet dinosaur."
p new_advice = advice.split(' ').each { |word| word.replace("urgent")if word == "important" }.join(" ")

# Exercise 4
# delete finds the value and removes it
# delete_at finds the index and removes it

# Exercise 5
puts (10..100).to_a.include?(42)
puts (10..100).cover?(42)

# Exercise 6
famous_words = "and seven years ago..."
p famous_words.prepend("Four score and ")
p famous_words.insert(0, "Four score and ")

# Exercise 7
def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"

5.times { how_deep.gsub!("number", "add_eight(number)") }
p how_deep

p eval(how_deep) # result is the number 42

# Exercise 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

p flintstones.flatten!

# Exercise 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3,
                "BamBam" => 4, "Pebbles" => 5 }
p flintstones.assoc("Barney")
p flintstones.select!{ |k, v| k == "Barney" }.to_a.flatten

# Exercise 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
f_hash = {}
flintstones.each_with_index { |item, index| f_hash[item] = index }
p f_hash
