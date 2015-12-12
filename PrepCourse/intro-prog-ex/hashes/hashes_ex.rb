# Exercise 1
family = { uncles: ['bob', 'joe', 'steve'],
           sisters: ['jane', 'jill', 'beth'],
           brothers: ['frank', 'rob', 'david'],
           aunts: ['mary', 'sally', 'susan']}
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}

immediate_family = family.select{ | k, v | (k == :sisters || k == :brothers)}.
                   values.flatten
p immediate_family

# Exercise 2
hash1 = { name: "Paolo", age: "31" }
hash2 = { gender: "Male" }

hash1.merge(hash2)
p hash1
hash1.merge!(hash2)
p hash1
# The merge methods with an '!' mutates the hash

# Exercise 3
family.each_key { | key | p key }
family.each_value { | value | p value }
family.each { | key, value | puts "'#{key.inspect}' has the following values #{value}" }

# Exercise 4
# person[:name]

# Exercise 5
# hash.has_value?(value)

# Exercise 6
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
# Get the unique words
wordsUnique = words.map{ | word | word.split(//).sort.join }.uniq
# Initialize the anagrams hash
anagrams = Hash.new
wordsUnique.each { | word | anagrams[word.to_sym] = [] }
# Populate the anagrams hash
wordsUnique.each do | key |
  arr = []
  words.each do | word |
    if word.split(//).sort.join == key
      arr << word
    end
  anagrams[key.to_sym] = arr
  end
end
anagrams.each { | k, v | p v }

# Exercise 7
# The two hashes have different keys. The first one uses the symbol ':x'
# while the second used the string contained in variable 'x'

# Exercise 8
# B
