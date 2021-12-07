require_relative '../setup'

def fuel(positions, constant_rate: true)
  total_fuel = []

  (positions.min...positions.max).each do |i|
    fuel_to_i = 0
    positions.each do |j|
      diff = (j - i).abs
      fuel_to_i += constant_rate ? diff : (diff * (diff + 1)) / 2
    end
    total_fuel << fuel_to_i
  end

  total_fuel.each_with_index.min.first
end

assert(37, fuel(test_file_data.split(',').map(&:to_i)))
assert(168, fuel(test_file_data.split(',').map(&:to_i), constant_rate: false))

p fuel(file_data.split(',').map(&:to_i))
p fuel(file_data.split(',').map(&:to_i), constant_rate: false)
