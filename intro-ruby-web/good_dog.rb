class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name, :height, :weight

  @@number_of_dogs = 0

  def initialize(name, height, weight)
    @name = name
    @height = height
    @weight = weight
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def change_info(name, height, weight)
    self.name = name
    self.height = height
    self.weight = weight
  end

  def speak
    "#{name} says Arf!"
  end

  def to_s
    "#{name} weighs #{weight} and is #{height} tall."
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def what_is_self
    self
  end

  def self.this_is_a_class_method
    self
  end
end

sparky = GoodDog.new("Sparky", 72, 150)


p sparky.speak
