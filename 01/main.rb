require_relative '../setup'

def count_increases(measurements)
  increase_num = 0
  measurements.each_cons(2) { |r, l| increase_num += 1 if r < l }
  increase_num
end

def count_window_increases(measurements)
  windows = measurements.each_cons(3).map(&:sum)
  count_increases(windows)
end

data = test_file_data.map(&:to_i)
assert(7, count_increases(data))
assert(5, count_window_increases(data))
puts

data = file_data.map(&:to_i)
puts "total increases: #{count_increases(data)}"
puts "window increases: #{count_window_increases(data)}"
