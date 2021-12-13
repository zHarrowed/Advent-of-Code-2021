## Run with 'ruby second.rb input.txt'

input = File.read(ARGV[0])
grid_input, instruction_input = input.split("\n\n")
max_y = 0
max_x = 0
grid_input = grid_input.lines.map do |dot|
  dot = dot.strip
  x, y = dot.split(",")
  x = x.to_i
  y = y.to_i
  max_y = y if y > max_y
  max_x = x if x > max_x
  [x, y]
end
grid = Array.new(max_y + 1) { Array.new(max_x + 1, ".") }
grid_input.each do |dot|
  x, y = dot
  grid[y][x] = "x"
end
instruction_input.lines.each do |instruction|
  instruction = instruction.strip.split(" ").last
  axis, fold_line = instruction.split("=")
  fold_line = fold_line.to_i
  if axis == "y"
    grid.delete_at(fold_line)
    (fold_line..(grid.size - 1)).each do |line_number|
      grid[line_number].each_with_index do |value, index|
        next unless value && value == "x"
        grid[(fold_line - 1) - line_number % fold_line][index] = "x"
      end
    end
    (grid.size - 1).downto(fold_line).each do |line_number|
      grid.delete_at(line_number)
    end
  end
  if axis == "x"
    grid.each do |line|
      line.delete_at(fold_line)
    end
    (fold_line..(grid.first.size - 1)).each do |row_number|
      grid.each_with_index do |line, index|
        value = line[row_number]
        next unless value && value == "x"

        grid[index][(fold_line - 1) - row_number % fold_line] = "x"
      end
    end
    (grid.first.size - 1).downto(fold_line).each do |line_number|
      grid.each do |line|
        line.delete_at(line_number)
      end
    end
  end
end

grid.each do |line|
  puts line.map{|elem| elem == "x" ? "■" : " "}.join(" ")
end