## Run with 'ruby second.rb input.txt'

lines = File.read(ARGV[0]).lines
lines = lines.map{_1.strip.split("").map(&:to_i)}
basin_sizes = []
height = lines.size
width = lines.first.size
explored = Array.new(lines.size) { Array.new(lines.first.size, 0) }

def map_basin(i, j, lines, explored, height, width)
  size = 0
  to_map = [[i,j]]
  while to_map.size > 0
    size += 1
    y,x = to_map.shift
    explored[y][x] = 1
    if x != 0 && explored[y][x-1] != 1 && lines[y][x-1] != 9 && !to_map.include?([y, x-1])
      to_map << [y, x-1]
    end
    if x != width - 1 && explored[y][x+1] != 1 && lines[y][x+1] != 9 && !to_map.include?([y, x+1])
      to_map << [y, x+1]
    end
    if y != 0 && explored[y-1][x] != 1 && lines[y-1][x] != 9 && !to_map.include?([y-1, x])
      to_map << [y-1, x]
    end
    if y != height - 1 && explored[y+1][x] != 1 && lines[y+1][x] != 9 && !to_map.include?([y+1, x])
      to_map << [y+1, x]
    end
  end

  size
end

lines.each_with_index do |line, i|
  line.each_with_index do |number, j|
    if number != 9 && explored[i][j] == 0
      basin_sizes << map_basin(i, j, lines, explored, height, width)
    end
  end
end

puts basin_sizes.sort[-3..-1].inject(:*)