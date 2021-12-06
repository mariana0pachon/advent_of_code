class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

def assert(expected, actual)
  if expected == actual
    puts '✓'.green
  else
    puts "F: expected #{expected} but got #{actual}".red
  end
end

def file_data
  day = File.basename(Dir.pwd).to_i
  unless File.file?('input')
    `curl https://adventofcode.com/2021/day/#{day}/input --cookie "session=#{ENV['SESSION']}" -o input`
  end
  File.read('input')
end

def test_file_data
  File.read('test')
end
