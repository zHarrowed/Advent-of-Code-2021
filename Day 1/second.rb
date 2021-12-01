## Run with 'ruby second.rb input.txt'

inc = 0
a = b = c = d = nil
File.read("input.txt").lines.each do |line|
  a = b
  b = c
  c = d
  d = line.to_i
  inc += 1 if !a.nil? && a < d
end
puts inc