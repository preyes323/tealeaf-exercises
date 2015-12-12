# Example of a method that modifies its argument permanently
# mutate.rb

a = [ 1, 2, 3 ]
b = [ 1, 2, 3 ]

def mutate(array)
  array.pop
end

def no_mutate(array)
  array.last
end

# Test with mutate
p "Before mutate method: #{a}"
p mutate(a)
p "After mutate method: #{a}"

# Test without mutate
p "Before no mutate method: #{b}"
p no_mutate(b)
p "After no mutate method: #{b}"
