# Answers to the exercises under easy portion for quiz 3

def separator(name)
  puts name.center(40, "--")
end

# Exercise 1
separator "Ex1"
p flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Exercise 2
separator "Ex2"
p flintstones << "Dino"

# Exercise 3
# flinstones.contact(["Dino", "Hoppy"])

# Exercise 4
separator "Ex4"
advice = "Few things in life are as important as house training your pet dinosaur."
p new_advice = advice.slice!(0, advice.index('house'))
p advice
# if "slice" is used, the original string remains the same

# Exercise 5
separator "Ex5"
statement = "The Flintstones Rock!"
p statement.count "t"

# Exercise 6
title = "Flintstone Family Members"
p " " * 40 + title
p title.center(40, "--")
