## Run with 'ruby second.rb input.txt'

input = File.read(ARGV[0]).strip
xs, ys = input.split(": ")[1].split(", ")
min_x, max_x = xs[2..].split("..").map(&:to_i)
min_y, max_y = ys[2..].split("..").map(&:to_i)

working_velocities = []
(1..(min_y.abs * 3)).each do |steps|
  x_velocities = (1..max_x).select do |x_vel|
    x=0
    steps.times do
      x += x_vel
      x_vel = x_vel > 0 ? x_vel - 1 : 0
    end
    (x>=min_x) && (x<=max_x)
  end
  y_velocities = (min_y..min_y.abs).select do |y_vel|
    y=0
    steps.times do
      y+=y_vel
      y_vel -= 1
    end
    (y>=min_y) && (y<=max_y)
  end
  x_velocities.each do |x|
    y_velocities.each do |y|
      working_velocities << [x,y]
    end
  end
end

puts working_velocities.compact.uniq.size
