## Run with 'ruby second.rb input.txt'

dice_weights = [1,2,3].product([1,2,3]).product([1,2,3]).map { _1.flatten.sum }.tally
from_to_weights = {}
(1..10).each do |from|
  dice_weights.each do |dice_result, weight|
    to = (from + dice_result)
    to -= 10 if to > 10
    from_to_weights[from] ||= {}
    from_to_weights[from][to] ||= 0
    from_to_weights[from][to] += weight
  end
end
ongoing = []
winning_weights = [0, 0]
input = File.read(ARGV[0]).lines
position_a = input[0].strip.rpartition(' ').last.to_i
position_b = input[1].strip.rpartition(' ').last.to_i
ongoing << {
  positions: [position_a, position_b],
  scores: [0, 0],
  weight: 1
}
until ongoing.empty?
  ongoing.size.times do
    reality = ongoing.shift
    from_to_weights[reality[:positions][0]].each do |to_a, weight_a|
      scores = [reality[:scores][0] + to_a, reality[:scores][1]]
      weight = weight_a * reality[:weight]
      if scores.max > 20
        if scores[0] >= scores[1]
          winning_weights[0] += weight
        else
          winning_weights[1] += weight
        end
      else
        from_to_weights[reality[:positions][1]].each do |to_b, weight_b|
          scores = [reality[:scores][0] + to_a, reality[:scores][1] + to_b]
          weight = weight_a * weight_b * reality[:weight]
          if scores.max > 20
            if scores[0] >= scores[1]
              winning_weights[0] += weight
            else
              winning_weights[1] += weight
            end
          else
            ongoing << {
              positions: [to_a, to_b],
              scores: scores,
              weight: weight
            }
          end
        end
      end
    end
  end
end

puts winning_weights.max