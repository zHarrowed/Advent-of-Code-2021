## Run with 'ruby first.rb input.txt'

pos = 0
depth = 0
File.read(ARGV[0]).lines.each do |line|
  command, value = line.split(' ')
  case command
  when "forward"
    pos += value.to_i
  when "up"
    depth -= value.to_i
  when "down"
    depth += value.to_i
  end
end
puts pos*depth