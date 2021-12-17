## Run with 'ruby first.rb input.txt'

input = File.read(ARGV[0]).strip
_xs, ys = input.split(": ")[1].split(", ")
min_y, max_y = ys[2..].split("..").map(&:to_i)

max_h = -1.0/0
(1..(min_y.abs * 3)).each do |steps|
  (min_y..min_y.abs).each do |y_vel|
    y=0
    max = 0
    steps.times do
      y+=y_vel
      y_vel -= 1
      max = y if max < y
    end
    if (y>=min_y) && (y<=max_y)
      max_h = max if max_h < max
    end
  end
end

puts max_h
