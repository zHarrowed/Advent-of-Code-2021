## Run with 'ruby second.rb input.txt'

# It's ridiculously slow but it works

def overlapping?(beacons, scanner)
  beacons.each do |i, j, k|
    scanner.each do |x, y, z|
      offset_x = i - x
      offset_y = j - y
      offset_z = k - z
      match_count = 0
      offset_scanner = []
      scanner.each_with_index do |(x1, y1, z1), index|
        coordinates = [x1 + offset_x, y1 + offset_y, z1 + offset_z]
        match_count += 1 if beacons.include?(coordinates)
        break if (12 - match_count) > (25 - index)
        offset_scanner << coordinates
      end

      if match_count >= 12
        return offset_scanner
      end
    end
  end
  return nil
end

scanners = File.read(ARGV[0]).split("\n\n")
scanners = scanners.map do |scanner|
  coordinates = scanner.lines
  coordinates = coordinates[1..]
  coordinates.map do |coordinate|
    coordinate.strip.split(",").map(&:to_i)
  end
end

beacons = []
beacons += scanners.delete_at(0)

eval_strings = []
[0,1,2].permutation(3).each do |elem1, elem2, elem3|
  ["", "-"].each do |op1|
    ["", "-"].each do |op2|
      ["", "-"].each do |op3|
        eval_strings << "[#{op1}coordinates[#{elem1}], #{op2}coordinates[#{elem2}], #{op3}coordinates[#{elem3}]]"
      end
    end
  end
end

until scanners.empty?
  deleted = []

  scanners.each_with_index do |scanner, index|
    eval_strings.each do |coordinate_eval_string|
      result = overlapping?(beacons,
                            scanner.map {|coordinates| eval(coordinate_eval_string)})
      if result
        offset_scanner = result
        beacons += offset_scanner
        beacons = beacons.uniq
        deleted << index
      end
      break if deleted.include?(index)
    end
  end

  deleted.each do |index|
    scanners.delete_at(index)
  end
end

puts beacons.size