require_relative '../setup'

def bingo(draw, boards, squid_wins = false)
  draw = draw.split(',')

  winning_indexes = []

  boards.each do |board|
    board = board.split("\n")
    board_win = Float::INFINITY

    board.each do |row|
      row = row.split
      if (row - draw).empty?
        row_win = draw.index(row.sort_by(&draw.method(:index)).last)
        board_win = [board_win, row_win].min
      end
    end

    board.map(&:split).transpose.each do |col|
      if (col - draw).empty?
        col_win = draw.index(col.sort_by(&draw.method(:index)).last)
        board_win = [board_win, col_win].min
      end
    end

    winning_indexes << board_win
  end

  winning_index = squid_wins ? winning_indexes.each_with_index.max : winning_indexes.each_with_index.min
  winner_board = boards[winning_index.last]
  (winner_board.split - draw[0..winning_index.first]).map(&:to_i).sum * draw[winning_index.first].to_i
end

data = test_file_data.split("\n\n")
assert(4512, bingo(data[0], data[1..-1]))
assert(1924, bingo(data[0], data[1..-1], true))

data = file_data.split("\n\n")
p bingo(data[0], data[1..-1])
p bingo(data[0], data[1..-1], true)
