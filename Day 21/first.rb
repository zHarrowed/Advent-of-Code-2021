## Run with 'ruby first.rb input.txt'

input = File.read(ARGV[0]).lines
position_a = input[0].strip.rpartition(' ').last.to_i
position_b = input[1].strip.rpartition(' ').last.to_i
positions = [position_a, position_b]
scores = [0, 0]

rounds = 0
dice_at = 0
until scores[0] >= 1000 || scores[1] >= 1000
  position = rounds % 2
  rounds += 1
  player_score = 0
  (1..3).each do |add|
    addition = (dice_at + add) % 100
    addition = 100 if addition == 0
    player_score += addition
  end
  dice_at += 3
  positions[position] += player_score
  positions[position] = positions[position] % 10
  positions[position] = 10 if positions[position] == 0
  scores[position] += positions[position]
end

puts (rounds * 3) * scores.min