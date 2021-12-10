require_relative '../setup'

def find_neighbors(matrix, row, col, basin: false)
  neighbors = []

  dirs = [
    [row - 1, col], # up
    [row, col + 1], # right
    [row + 1, col], # down
    [row, col - 1]  # left
  ]

  dirs.each do |r, c|
    if r.between?(0, matrix.length - 1) && c.between?(0, matrix.first.length - 1) && (basin ? matrix[row][col].to_i < matrix[r][c].to_i : true)
      neighbors << {
        value: matrix[r][c],
        coords: [r, c]
      }
    end
  end

  neighbors
end

def low_points(matrix)
  low_points = []

  matrix.each_with_index do |row, i|
    row.each_with_index do |col, j|
      neighbors = find_neighbors(matrix, i, j).map { |n| n[:value] }
      if neighbors.all? { |n| n > col }
        low_points << {
          value: col,
          coords: [i, j]
        }
      end
    end
  end

  low_points
end

def risk_sum(matrix)
  low_points(matrix).map { |lo| lo[:value].to_i + 1 }.sum
end

def find_basin(matrix, row, col, basin = [])
  return basin if matrix[row][col] == '9'

  basin << [row, col]

  neighbors = find_neighbors(matrix, row, col, basin: true)

  matrix[row][col] = '9'

  neighbors.each { |n| find_basin(matrix, n[:coords][0], n[:coords][1], basin) }

  basin
end

def sum_top_basins(matrix, top_count = 3)
  low_points(matrix).map { |lo| find_basin(matrix, lo[:coords][0], lo[:coords][1]) }.sort_by(&:length).last(top_count).map(&:length).inject(:*)
end

test_data = test_file_data.split("\n").map { |r| r.split('') }
data = file_data.split("\n").map { |r| r.split('') }

# Part 1
assert(15, risk_sum(test_data))
p risk_sum(data)

# Part 2
assert(1134, sum_top_basins(test_data))
p sum_top_basins(data)
