require_relative '../setup'

def syntax_error_score(input, type:)
  opening = ['(', '[', '{', '<']
  closing = [')', ']', '}', '>']

  corrupt_chars = []
  incomplete_chars = []

  input.split("\n").each do |line|
    queue = []
    line.split('').each do |char|
      queue << char and next if opening.include?(char)

      corrupt_chars << char and queue = [] and break if opening.index(queue.pop) != closing.index(char)
    end
    incomplete_chars << queue unless queue.empty?
  end

  case type
  when 'corrupt'
    scores = [3, 57, 1197, 25_137]
    corrupt_chars.map { |e| scores[closing.index(e)] }.sum
  when 'incomplete'
    scores = [1, 2, 3, 4]
    total_scores = []
    incomplete_chars.each do |line|
      score = 0
      line.reverse.each { |char| score = score * 5 + scores[opening.index(char)] }
      total_scores << score
    end
    total_scores.sort[total_scores.length / 2]
  end
end

assert(26_397, syntax_error_score(test_file_data, type: 'corrupt'))
p syntax_error_score(file_data, type: 'corrupt')

assert(288_957, syntax_error_score(test_file_data, type: 'incomplete'))
p syntax_error_score(file_data, type: 'incomplete')
