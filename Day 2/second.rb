## Run with 'ruby second.rb input.txt'

pos = 0
depth = 0
aim = 0
File.read(ARGV[0]).lines.each do |line|
  command, value = line.split(' ')
  case command
  when "forward"
    pos += value.to_i
    depth += aim*value.to_i
  when "up"
    aim -= value.to_i
  when "down"
    aim += value.to_i
  end
end
puts pos*depth