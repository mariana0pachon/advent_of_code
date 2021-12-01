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
  File.read('input').split
end

def test_file_data
  File.read('test').split
end
