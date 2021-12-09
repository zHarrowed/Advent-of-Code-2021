## Run with 'ruby first.rb input.txt'

lines = File.read(ARGV[0]).lines
lines = lines.map{_1.strip.split("").map(&:to_i)}
sum = 0
height = lines.size
width = lines.first.size

lines.each_with_index do |line, i|
  line.each_with_index do |number, j|
    left = (j == 0) ? 1.0/0 : lines[i][j-1]
    right = (j == width - 1)  ? 1.0/0 : lines[i][j+1]
    up = (i == 0) ? 1.0/0 : lines[i-1][j]
    down = (i == height - 1)  ? 1.0/0 : lines[i+1][j]
    if number < left && number < right && number < up && number < down
      sum += number + 1
    end
  end
end

puts sum