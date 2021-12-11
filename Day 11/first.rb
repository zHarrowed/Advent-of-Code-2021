## Run with 'ruby first.rb input.txt'

grid = []
File.read(ARGV[0]).lines.each do |line|
  grid << line.strip.split("").map(&:to_i)
end
count = 0
width = grid.first.size
height = grid.size
100.times do
  grid.each_with_index do |line, i|
    line.each_with_index do |value, j|
      grid[i][j] = value + 1
    end
  end
  while grid.find { |line| line.find {|value| value > 9} }
    grid.each_with_index do |line, i|
      line.each_with_index do |value, j|
        if value > 9
          grid[i][j] = -Float::INFINITY
          count += 1
          grid[i][j-1] += 1 unless j == 0
          grid[i][j+1] += 1 unless j == width - 1
          grid[i-1][j] += 1 unless i == 0
          grid[i+1][j] += 1 unless i == height - 1
          grid[i-1][j-1] += 1 unless i == 0 || j == 0
          grid[i-1][j+1] += 1 unless i == 0 || j == width - 1
          grid[i+1][j-1] += 1 unless i == height - 1 || j == 0
          grid[i+1][j+1] += 1 unless i == height - 1 || j == width - 1
        end
      end
    end
  end
  grid.each_with_index do |line, i|
    line.each_with_index do |value, j|
      if value == -Float::INFINITY
        grid[i][j] = 0
      end
    end
  end
end
grid.each do |line|
  puts line.join("")
end

puts count