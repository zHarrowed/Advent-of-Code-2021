## Run with 'ruby second.rb input.txt'

scores = []
File.read(ARGV[0]).lines.each do |line|
  line_stack = []
  line = line.strip
  line_length = line.size
  line.split("").each_with_index do |bracket, index|
    if ["(", "[", "{", "<"].include?(bracket)
      line_stack << bracket
    else
      opening_bracket = line_stack.pop
      unless (opening_bracket == "(" && bracket == ")") ||
        (opening_bracket == "[" && bracket == "]") ||
        (opening_bracket == "{" && bracket == "}") ||
        (opening_bracket == "<" && bracket == ">")
        break
      end
    end
    if index == line_length - 1
      score = line_stack.reverse.reduce(0) do |sum, item|
        sum = sum * 5
        sum += 1 if item == "("
        sum += 2 if item == "["
        sum += 3 if item == "{"
        sum += 4 if item == "<"
        sum
      end
      scores << score
    end
  end
end

puts scores.sort[scores.size / 2]
