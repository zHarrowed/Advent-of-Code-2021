## Run with 'ruby second.rb input.txt'

positions = []
File.read(ARGV[0]).lines.first.split(',').map(&:to_i).each do |position|
  positions << position
end
results = (0..positions.max).map do |position|
  positions.sum do |aim|
    n = (position - aim).abs
    ((n + n % 2) / 2) * (1 + n)
  end
end
puts results.min