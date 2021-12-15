## Run with 'ruby second.rb input.txt'

nodes = File.read(ARGV[0]).lines.map.with_index do |line, i|
  line.strip.split("").map.with_index { |item, j| { route_weight: 1.0/0, visited: false, node_weight: item.to_i, y: i, x: j } }
end
max_height = nodes.size - 1
max_width = nodes.first.size - 1

i = 0
j = 0
nodes[i][j][:route_weight] = 0
nodes[i][j][:visited] = true
usable_nodes = []

until i == max_height && j == max_width
  neighbours = []
  neighbours << nodes[i-1][j] if i > 0 && !nodes[i-1][j][:visited]
  neighbours << nodes[i+1][j] if i < max_height && !nodes[i+1][j][:visited]
  neighbours << nodes[i][j-1] if j > 0 && !nodes[i][j-1][:visited]
  neighbours << nodes[i][j+1] if j < max_width && !nodes[i][j+1][:visited]
  neighbours.each do |neighbour|
    if neighbour[:route_weight] > (nodes[i][j][:route_weight] + neighbour[:node_weight])
      neighbour[:route_weight] = nodes[i][j][:route_weight] + neighbour[:node_weight]
      usable_nodes << neighbour
    end
  end
  selected = usable_nodes.min { _1[:route_weight] <=> _2[:route_weight] }
  selected[:visited] = true
  usable_nodes.delete(selected)
  i = selected[:y]
  j = selected[:x]
end

puts nodes[i][j][:route_weight]