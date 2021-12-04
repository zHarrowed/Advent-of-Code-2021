## Run with 'ruby first.rb boards_input.txt numbers_input.txt'

boards = []
File.read(ARGV[0]).lines.select{|l| !l.strip.empty?}.each_slice(5) do |l|
  boards << l.map{|x|x.strip.split(' ').map(&:to_i)}
end
answer = nil
File.read(ARGV[1]).lines.first.strip.split(',').map(&:to_i).each do |number|
  break if answer
  boards.each_with_index do |board|
    break if answer
    column_count = [0,0,0,0,0]
    board.each_with_index do |line, i|
      line_count = 0
      line.each_with_index do |value, j|
        if number == value || value == "x"
          board[i][j] = "x"
          line_count += 1
          column_count[j] += 1
          if line_count >= 5 || column_count[j] >= 5
            answer = board.sum {|x| x.select{|y| y!="x"}.sum} * number
          end
        end
      end
    end
  end
end
puts answer