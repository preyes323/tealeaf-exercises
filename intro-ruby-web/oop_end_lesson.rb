
class Vehicle
  attr_reader :plate_number

  @@vehicle_count = 0

  def initialize(plate_number)
    @plate_number = plate_number
    @@vehicle_count += 1
  end

  def self.total
    @@vehicle_count
  end

  def to_s
    plate_number
  end
end

car1 = Vehicle.new("YO8380")
puts Vehicle.total
puts car1

puts Vehicle.ancestors
puts Vehicle.instance_methods
