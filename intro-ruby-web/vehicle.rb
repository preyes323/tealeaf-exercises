require 'pry'
module Travellable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
    # distance = @fuel_capacity * @fuel_efficiency
    # class_stack = self.class.ancestors.map { |item| item.to_s }
    # distance += 10 if class_stack.include?("Seacraft")
    # distance
  end
end

class WheeledVehicle
  include Travellable


  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tire_array = tire_array
    self.fuel_capacity = liters_of_fuel_capacity
    self.fuel_efficiency = km_traveled_per_liter
  end

  def tire_pressure(tire_index)
    @tire_array[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tire_array[tire_index] = pressure
  end

end

class Auto < WheeledVehicle
  def initialize
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    super([20, 20], 80, 8.0)
  end
end

class Seacraft
  include Travellable
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_capacity = liters_of_fuel_capacity
    self.fuel_efficiency = km_traveled_per_liter
    @propeller_count = num_propellers
    @num_hulls = num_hulls
  end

  def range
    range_by_using_fuel = super
    range_by_using_fuel + 10
  end
end

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
    super
  end
end

class Motorboat < Catamaran
  PROPELLER_COUNT = 1
  HULL_COUNT = 1

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(PROPELLER_COUNT, HULL_COUNT, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

catamaran = Catamaran.new(2, 1, 20, 10)
puts catamaran.range
car1 = Auto.new
puts car1.range
