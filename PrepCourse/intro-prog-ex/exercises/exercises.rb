# Answers to the exercises chapter

num_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

def separator
  puts "----------"
end

# Exercise 1
num_arr.each { |num| puts num }

separator

# Exercise 2
num_arr.each { |num| puts num if num > 5 }

separator

# Exercise 3
p new_arr = num_arr.select { |num| num.odd? }

separator

# Exercise 4
p num_arr.push(11).unshift(0)

separator

# Exercise 5
p num_arr.pop
p num_arr.push(3)

separator

# Exercise 6
p num_arr.uniq!

# Exericse 7
# An array make use of indexes as keys, while hashes makes use associative keys

separator

# Exercise 8
p hash1 = Hash.new
p hash2 = {}

p hash1 = { :item1 => "Item1" }
p hash2 = { item1: "Item1" }

separator

# Exercise 9
p h = {a:1, b:2, c:3, d:4}
p h[:b]
p h[:e] = 5
p h.select! { |k ,v| v >= 3.5 }

separator

# Exercise 10
# Yes, values in hash can be arrays.
# Hash values as arrays
p favorites = { food: ['pizza', 'steak'], color: ['blue', 'white'] }
# Array of hashes
p subjects = [ { math: "1st" }, { science: "2nd" }, { history: "3rd" } ]

# Exercise 11
# One API I find useful is for strings. Much of input that I have gotten has
# come in the form of strings. I feel that being able to manipulate strings
# is critical in being able make use of the available data. Numbers are good,
# but inputs are typically 'Number' represented as strings

separator

# Exercise 12 and 14
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
data = [:email, :address, :phone]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# This program assumes that contacts and contact_data are arranged the same way
# and that data is limited to the 3 available.
index1 = 0
index2 = 0
contacts.each_key do |key|
  data.each do |k|
    contacts[key][k] = contact_data[index1][index2]
    index2 += 1
  end
  index2 = 0
  index1 += 1
end
p contacts

separator

# Exercise 13
p contacts["Joe Smith"][:email]
p contacts["Sally Johnson"][:phone]

separator

# Exercise 15
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
p arr.delete_if { |a| a.start_with?('s') }
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
p arr.delete_if { |a| a.start_with?('s', 'w') }

separator

# Exercise 16
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
p new_a = a.map{ |entry| entry.split(" ") }.flatten

separator

# Exercise 17
# These hashes are the same will be printed out. Order is not important in
# hashes.

hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end
