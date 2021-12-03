## Run with 'ruby first.rb input.txt'

lines = File.read(ARGV[0]).lines.map(&:strip)
length = lines.first.size
a = Array.new(length, 0)
lines.each do |line|
  line.chars.each_with_index do |byte, i|
    a[i] += 1 if byte == "1"
  end
end
gamma = ""
epsilon = ""
a.each do |amount|
  rate = amount.to_f/lines.size >= 0.5
  gamma += rate ? "1" : "0"
  epsilon += rate ? "0" : "1"
end
puts gamma.to_i(2) * epsilon.to_i(2)