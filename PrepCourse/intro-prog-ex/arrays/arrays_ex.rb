# Exercise 1
arr = [1, 3, 5, 7, 9, 11]
number = 3
puts arr.include?(number)

# Exercise 2
# 1. => [["b", 1], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
#    => 1
#    arr = [["b"], ["b", 2], ["b", 3], ["a", 1], ["a", 2], ["a", 3]]
# 2. => [["b", [1, 2, 3]], ["a", [1, 2, 3]]]
#    => [1, 2, 3]
#    arr = [["b"], ["a", [1, 2, 3]]]

# Exercise 3
arr = [["test", "hello", "world"],["example", "mem"]]
puts arr.last.first

# Exercise 4
# 1. 3
# 2. error
# 3. 8

# Exercise 5
# e, T, A

# Exercise 6
# The array makes use of the index to access a value.
# Use the index of 'margaret' = 3; names[3] = 'jody'

# Exercise 7
arr = [1, 2, 3, 4]
new_arr = arr.map { |e| e + 2 }
p arr
p new_arr
