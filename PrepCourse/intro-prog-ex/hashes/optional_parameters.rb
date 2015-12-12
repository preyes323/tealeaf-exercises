# optional_parameters.rb

def greetings(name, options = {})
  if options.empty?
    puts "Hi! My name is #{name}"
  else
    puts "Hi! My name is #{name}. I live in #{options[:city]}. I am" +
         " #{options[:age]}."
  end
end

greetings("Bob")
greetings("Bob", city: 'Manila', age: 65)
