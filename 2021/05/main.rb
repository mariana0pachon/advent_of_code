require '../setup'

def dangerous_area_count(lines)
  lines = lines
          .map { |l| l.split('->').map { |i| i.split(',').map(&:to_i) } }
          .map(&:sort)

  grid = Array.new(lines.flatten.max + 1) { Array.new(lines.flatten.max + 1) { 0 } }

  lines.each do |l|
    if l[0][0] == l[1][0]
      (l[0][1]..l[1][1]).each do |c|
        grid[l[0][0]][c] += 1
      end
    elsif l[0][1] == l[1][1]
      (l[0][0]..l[1][0]).each do |c|
        grid[c][l[0][1]] += 1
      end
    else
      r = l[0][0]
      c = l[0][1]
      if l[1][1] < l[0][1]
        while r <= l[1][0] && c >= l[1][1]
          grid[r][c] += 1
          r += 1
          c -= 1
        end
      else
        while r <= l[1][0] && c <= l[1][1]
          grid[r][c] += 1
          r += 1
          c += 1
        end
      end
    end
  end

  grid.flatten.count { |g| g >= 2 }
end

data = test_file_data.split("\n")
assert(12, dangerous_area_count(data))

data = file_data.split("\n")
assert(22_364, dangerous_area_count(data))
