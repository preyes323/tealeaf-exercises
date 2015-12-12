module Swimmable
  def swim
    "#{name} is swimming!"
  end
end

class Animal
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def speak
    "#{name} is speaking!"
  end
end

class Mammal < Animal
  def warm_blooded?
    true
  end
end

class Dog < Mammal
  include Swimmable

  @@dog_count = 0

  def self.total_number_of_dogs
    "You have #{@@dog_count} dogs!"
  end

  def initialize(n, h, w)
    super(n, h, w)
    @@dog_count += 1
  end

  def speak
    "#{name} barks!"
  end

  def to_s
    "#{name} is #{height} ft. tall and #{weight} pounds heavy!"
  end

  def update_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
end

class Cat < Mammal
  include Swimmable
  def to_s
    "Meooww"
  end
end

teddy = Dog.new('teddy', 3, 85)
mika = Dog.new('Mika', 5, 35)
angela = Cat.new('Angela', 3, 5)
puts angela.swim
puts teddy
puts angela
puts Dog::total_number_of_dogs
puts Cat.ancestors
