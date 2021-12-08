## Run with 'ruby second.rb input.txt'

lines = File.read(ARGV[0]).lines

# The code is garbage but don't have time to improve
sum = 0
lines.each do |line|
  decoder = []
  keys, values = line.split(" | ")
  keys = keys.split
  values = values.split
  decoder[1] = keys.find { |x| x.size == 2}
  keys.delete(decoder[1])
  decoder[4] = keys.find { |x| x.size == 4}
  keys.delete(decoder[4])
  decoder[7] = keys.find { |x| x.size == 3}
  keys.delete(decoder[7])
  decoder[8] = keys.find { |x| x.size == 7}
  keys.delete(decoder[8])
  decoder[9] = keys.find { |x| x.size == 6 && (x.chars - decoder[4].chars).size == 2 }
  keys.delete(decoder[9])
  decoder[6] = keys.find { |x| x.size == 6 && (x.chars - decoder[9].chars).size == 1 && (x.chars - decoder[7].chars).size == 4 }
  keys.delete(decoder[6])
  decoder[0] = keys.find { |x| x.size == 6}
  keys.delete(decoder[0])
  decoder[3] = keys.find { |x| (x.chars - decoder[7].chars).size == 2 }
  keys.delete(decoder[3])
  decoder[2] = keys.find { |x| (x.chars - decoder[9].chars).size == 1 }
  keys.delete(decoder[2])
  decoder[5] = keys.first

  value_string = values.sum("") do |value|
    decoder.find_index(decoder.find { |z| value.size == z.size && (value.chars - z.chars).empty? }).to_s
  end
  sum += value_string.to_i
end
puts sum
