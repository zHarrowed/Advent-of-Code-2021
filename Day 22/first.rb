## Run with 'ruby first.rb input.txt'

class Range
  def overlaps?(other)
    cover?(other.first) || other.cover?(first)
  end

  def intersection(other)
    inters = self.to_a & other.to_a

    inters.empty? ? nil : inters.min..inters.max
  end
  alias_method :&, :intersection
end

def add_exclusion(cube, overlapping_cube)
  new_exclusion = {
    x_range: cube[:x_range] & overlapping_cube[:x_range],
    y_range: cube[:y_range] & overlapping_cube[:y_range],
    z_range: cube[:z_range] & overlapping_cube[:z_range],
    exclusions: []
  }
  cube[:exclusions].each do |exclusions_cube|
    next unless new_exclusion[:x_range].overlaps?(exclusions_cube[:x_range])
    next unless new_exclusion[:y_range].overlaps?(exclusions_cube[:y_range])
    next unless new_exclusion[:z_range].overlaps?(exclusions_cube[:z_range])

    add_exclusion(exclusions_cube, new_exclusion)
  end
  cube[:exclusions] << new_exclusion
end

def cube_volume(cube)
  exclusion_volume = cube[:exclusions].sum { cube_volume(_1) }
  cube[:x_range].size * cube[:y_range].size * cube[:z_range].size - exclusion_volume
end

cubes_on = []
File.read(ARGV[0]).strip.lines.each do |line|
  instruction, coordinates = line.strip.split(" ")
  x_range, y_range, z_range = coordinates.split(",").map { eval(_1[2..]) }

  next if x_range.first > 50 || y_range.first > 50 || z_range.first > 50
  next if x_range.last < -50 || y_range.first < -50 || z_range.first < -50

  x_range = (x_range.first..50) if x_range.last > 50
  y_range = (y_range.first..50) if y_range.last > 50
  z_range = (z_range.first..50) if z_range.last > 50
  x_range = (-50..x_range.last) if x_range.first < -50
  y_range = (-50..y_range.last) if y_range.first < -50
  z_range = (-50..z_range.last) if z_range.first < -50

  cube = {
    x_range: x_range,
    y_range: y_range,
    z_range: z_range,
    exclusions: []
  }
  cubes_on.each do |cube_on|
    next unless cube[:x_range].overlaps?(cube_on[:x_range])
    next unless cube[:y_range].overlaps?(cube_on[:y_range])
    next unless cube[:z_range].overlaps?(cube_on[:z_range])

    add_exclusion(cube_on, cube)
  end

  if instruction == "on"
    cubes_on << cube
  end
end

total = cubes_on.sum { cube_volume(_1) }

puts total