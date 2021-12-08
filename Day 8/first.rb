## Run with 'ruby second.rb input.txt'

lines = File.read(ARGV[0]).lines

# The code is garbage but don't have time to improve
sum = 0
lines.each do |line|
  _keys, values = line.split(" | ")
  values = values.split

  sum += values.select { |x| x.size == 2 || x.size == 4 || x.size == 3 || x.size == 7}.size
end
puts sum
