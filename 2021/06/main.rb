require_relative '../setup'

def count_fish(fish, days)
  count_by_age = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0, 8 => 0 }

  count_by_age.each { |age, _count| count_by_age[age] = fish.count(age) }

  (0..days - 1).each do
    new_fish_today = count_by_age[0]
    count_by_age.each { |age, _count| count_by_age[age - 1] = count_by_age[age] if age.positive? }
    count_by_age[6] += new_fish_today
    count_by_age[8] = new_fish_today
  end

  count_by_age.values.sum
end

assert(26, count_fish(test_file_data.split(',').map(&:to_i), 18))
assert(5934, count_fish(test_file_data.split(',').map(&:to_i), 80))
assert(26_984_457_539, count_fish(test_file_data.split(',').map(&:to_i), 256))

p count_fish(file_data.split(',').map(&:to_i), 80)
p count_fish(file_data.split(',').map(&:to_i), 256)
