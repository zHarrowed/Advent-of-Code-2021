## Run with 'ruby second.rb input.txt'

def increase_point_value(grid, x, y)
  grid[y] ||= []
  grid[y][x] ||= 0
  grid[y][x] += 1
end

grid = []
File.read(ARGV[0]).lines.each do |line|
  from, to = line.strip.split(" -> ")
  from_x, from_y = from.split(",").map(&:to_i)
  to_x, to_y = to.split(",").map(&:to_i)
  if from_x == to_x
    min = [from_y, to_y].min
    max = [from_y, to_y].max
    (min..max).each do |y|
      increase_point_value(grid, from_x, y)
    end
  elsif from_y == to_y
    min = [from_x, to_x].min
    max = [from_x, to_x].max
    (min..max).each do |x|
      increase_point_value(grid, x, from_y)
    end
  end
end

puts grid.sum {|line| line ? line.sum {|value| value && value > 1 ? 1 : 0} : 0}
