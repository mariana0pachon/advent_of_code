require_relative '../setup'

def consumption(diagnostic)
  total = diagnostic.length
  gamma = ''
  epsilon = ''
  diagnostic.map(&:chars).transpose.map do |col|
    gamma += col.count('1') > total / 2 ? '1' : '0'
    epsilon += col.count('1') > total / 2 ? '0' : '1'
  end
  gamma.to_i(2) * epsilon.to_i(2)
end

def life_support(diagnostic)
  one_and_zero = diagnostic.partition { |elt| elt[0] == '1' }.sort_by(&:length)

  co2(one_and_zero[0]).to_i(2) * oxygen(one_and_zero[1]).to_i(2)
end

def co2(diagnostic, position = 1)
  return diagnostic[0] if diagnostic.length == 1

  min = diagnostic.map(&:chars).transpose[position].count('0') > diagnostic.length / 2 ? '1' : '0'
  selected = diagnostic.select { |elt| elt[position] == min }
  co2(selected, position + 1)
end

def oxygen(diagnostic, position = 1)
  return diagnostic[0] if diagnostic.length == 1

  current_col = diagnostic.map(&:chars).transpose[position]
  max = current_col.count('1') == current_col.count('0') || current_col.count('1') > diagnostic.length / 2 ? '1' : '0'
  selected = diagnostic.select { |elt| elt[position] == max }
  oxygen(selected, position + 1)
end

assert(198, consumption(test_file_data.split))
p consumption(file_data.split)

assert(230, life_support(test_file_data.split))
p life_support(file_data.split)
