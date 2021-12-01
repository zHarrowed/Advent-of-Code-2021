## Run with 'ruby first.rb input.txt'

inc = 0
prev = nil
File.read(ARGV[0]).lines.each do |line|
  inc += 1 if prev && line.to_i > prev
  prev = line.to_i
end
puts inc