require_relative '../setup'

def position(movements)
  sum = { forward: 0, up: 0, down: 0 }

  movements.each_slice(2).each do |direction, amount|
    sum[:"#{direction}"] += amount.to_i
  end

  (sum[:down] - sum[:up]) * sum[:forward]
end

def position_with_aim(movements)
  aim = 0
  horizontal = 0
  depth = 0

  movements.each_slice(2).each do |direction, amount|
    amount = amount.to_i

    case direction
    when 'forward'
      horizontal += amount
      depth += aim * amount
    when 'down'
      aim += amount
    when 'up'
      aim -= amount
    end
  end

  horizontal * depth
end

assert(150, position(test_file_data))
puts position(file_data)

assert(900, position_with_aim(test_file_data))
puts position_with_aim(file_data)
