## Run with 'ruby first.rb input.txt'

caves = {}
paths = []
File.read(ARGV[0]).lines.each do |line|
  departure, destination = line.split("-")
  departure = departure.strip
  destination = destination.strip
  caves[departure] ||= []
  caves[departure] = caves[departure].push(destination).uniq
  caves[destination] ||= []
  caves[destination] = caves[destination].push(departure).uniq
end

paths << ["start"]
while !(paths.all? {|path| path.last == "end"})
  paths.each_with_index do |path, index|
    next if path.last == "end"

    current = path.last
    destinations = caves[current].select do |destination|
      if destination.downcase == destination
        !path.include?(destination)
      else
        true
      end
    end
    if destinations.empty?
      paths[index] = nil
    else
      destinations[1..]&.each do |destination|
        paths << path.dup.push(destination) unless destination.empty?
      end
      paths[index] << destinations.first
    end
  end
  paths = paths.compact
end

puts paths.uniq.size