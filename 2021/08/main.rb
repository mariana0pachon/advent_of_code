require_relative '../setup'

# part 1
def count_digits(segments)
  segments.map { |s| s.split('|').last.split }.flatten.count { |o| [2, 4, 3, 7].include?(o.length) }
end

assert(26, count_digits(test_file_data.split("\n")))
p count_digits(file_data.split("\n"))

# part 2
def sort_word(word)
  word.split('').sort.join
end

def decode(dictionary)
  mapping = Array.new(10)

  mapping[1] = dictionary.find { |num| num.length == 2 }
  mapping[4] = dictionary.find { |num| num.length == 4 }
  mapping[7] = dictionary.find { |num| num.length == 3 }
  mapping[8] = dictionary.find { |num| num.length == 7 }

  mapping[9] = dictionary.find { |num| num.length == 6 && (num.chars - (mapping[4] + mapping[7]).chars).length == 1 }

  dictionary.select { |num| num.length == 6 && num != mapping[9] }.each do |n|
    n.include?(mapping[1][0]) && n.include?(mapping[1][1]) ? mapping[0] = n : mapping[6] = n
  end

  dictionary.select { |num| num.length == 5 }.each do |n|
    if (n.chars - mapping[6].chars).empty?
      mapping[5] = n
    else
      n.include?(mapping[1][0]) && n.include?(mapping[1][1]) ? mapping[3] = n : mapping[2] = n
    end
  end

  mapping.map { |map| sort_word(map) }
end

def sum_outputs(entries)
  sum = 0
  entries.each do |entry|
    four_digits = ''
    patterns, output = entry.split('|')
    patterns = decode(patterns.split)
    output.split.each { |o| four_digits << patterns.index(sort_word(o)).to_s }
    sum += four_digits.to_i
  end
  sum
end

data = test_file_data.split("\n")
assert(61_229, sum_outputs(data))

data = file_data.split("\n")
p sum_outputs(data)
