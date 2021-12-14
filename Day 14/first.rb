## Run with 'ruby first.rb input.txt'

polymer, rules = File.read(ARGV[0]).split("\n\n")
rules = rules.split("\n").map{_1.split" -> "}.to_h
pair_counts = {}
character_counts = {}
polymer.chars.each_cons(2) do |a,b|
  character_counts[a] ||= 0
  character_counts[a] += 1
  if pair_counts[a+b]
    pair_counts[a+b] += 1
  else
    pair_counts[a+b] = 1
  end
end
character_counts[polymer.chars.last] ||= 0
character_counts[polymer.chars.last] += 1

10.times do
  new_pair_counts = pair_counts.clone
  pair_counts.each do |pair, count|
    a, b = pair.chars
    inserted = rules[pair]
    new_pair_counts[pair] -= count
    new_pair_counts[a + inserted] ||= 0
    new_pair_counts[a + inserted] += count
    new_pair_counts[inserted + b] ||= 0
    new_pair_counts[inserted + b] += count
    character_counts[inserted] ||= 0
    character_counts[inserted] += count
  end
  pair_counts = new_pair_counts.clone
end

least_common, *_middle, most_common = character_counts.sort_by(&:last)
puts most_common[1] - least_common[1]