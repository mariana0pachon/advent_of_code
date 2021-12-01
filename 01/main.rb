def count_increases(measurements)
  increase_num = 0
  measurements.each_cons(2) { |r, l| increase_num += 1 if r < l }
  increase_num
end

def count_window_increases(measurements)
  windows = measurements.each_cons(3).map(&:sum)
  count_increases(windows)
end

file_data = File.read('input').split.map(&:to_i)
puts "total increases: #{count_increases(file_data)}"
puts "window increases: #{count_window_increases(file_data)}"
