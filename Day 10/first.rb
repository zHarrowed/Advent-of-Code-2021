## Run with 'ruby first.rb input.txt'

points = 0
File.read(ARGV[0]).lines.each do |line|
  line_stack = []
  line.strip.split("").each do |bracket|
    if ["(", "[", "{", "<"].include?(bracket)
      line_stack << bracket
    else
      opening_bracket = line_stack.pop
      unless (opening_bracket == "(" && bracket == ")") ||
        (opening_bracket == "[" && bracket == "]") ||
        (opening_bracket == "{" && bracket == "}") ||
        (opening_bracket == "<" && bracket == ">")
        points += 3 if bracket == ")"
        points += 57 if bracket == "]"
        points += 1197 if bracket == "}"
        points += 25137 if bracket == ">"

        break
      end
    end
  end
end

puts points
