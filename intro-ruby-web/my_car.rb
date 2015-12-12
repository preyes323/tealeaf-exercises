module Haulerable

  def can_haul?(capacity, demand)
    capacity > demand ? true : false
  end
end

class Vehicle
  attr_accessor :color, :model, :speed, :year
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    self.speed = 0
    self.year = 2000
    self.color = color
    self.model = model
    @@number_of_vehicles += 1
  end

  def self.total_number_of_vehicles
      @@number_of_vehicles
  end

  def self.gas_mileage(liters, km)
    puts ("Your vehicle travels #{(km / liters.to_f).round(2)} " +
          " kilometers per liter of gas")
  end

  def age
    "Your vehicle is #{years_old} years old!"
  end

  private
    def years_old
      Time.now.year - self.year
    end
end


class MyCar < Vehicle
  attr_accessor :number_of_doors
  NUMBER_OF_WHEELS = 4

  def initialize(year, color, model, number_of_doors)
    super(year, color, model)
    self.number_of_doors = number_of_doors
  end

  def speed_up(speed = 2)
    self.speed += speed
  end

  def break(speed = -2)
    self.speed -= speed
  end

  def spray_paint(color)
    self.color = color
    puts "The car is now color #{color}!"
  end

  def shut_off
    self.speed = 0
  end

  def track_car
    "The car is currently travelling #{speed} km/hr."
  end

  def to_s
    if self.number_of_doors <= 2
      "Wow you're driving a sports car!"
    else
      ("Your #{model} color is #{color}. This car was " +
      "introduced to the market on the year #{year}.")
    end
  end

  def car_age
    age
  end
end


class MyTruck < Vehicle
  include Haulerable
  attr_reader :CAPACITY

  NUMBER_OF_WHEELS = 10
  CAPACITY = 3000

  def initialize(year, color, model)
    super(year, color, model)
    @CAPACITY = CAPACITY
  end

  def to_s
    "Trucks have #{NUMBER_OF_WHEELS} wheels!"
  end
end

car1 = MyCar.new "1999", "Red", "Ford", 2
puts car1
car2 = MyCar.new "1999", "Red", "Ford", 4
puts car2

puts MyCar.gas_mileage(15, 2)

puts MyTruck.gas_mileage(30, 2)
truck1 = MyTruck.new "2001", "Pink", "Isuzu"
puts "My truck can haul 2000kgs? #{truck1.can_haul?(2000, truck1.CAPACITY)}"
puts truck1

puts Vehicle.total_number_of_vehicles

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors


puts car1.age
puts car1.instance_variables

puts MyCar::NUMBER_OF_WHEELS
