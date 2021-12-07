## Run with 'ruby first.rb input.txt'

positions = []
File.read(ARGV[0]).lines.first.split(',').map(&:to_i).each do |position|
  positions << position
end
results = (0..positions.max).map do |position|
  positions.sum do |aim|
    (position - aim).abs
  end
end
puts results.min