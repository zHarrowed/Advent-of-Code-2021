## Run with 'ruby second.rb input.txt'

lines = File.read(ARGV[0]).lines.map(&:strip)
length = lines.first.size
oxygen_numbers = lines
co_numbers = lines
length.times do |index|
  if oxygen_numbers.size > 1
    oxygen_amount = 0
    oxygen_numbers.each do |line|
      oxygen_amount += 1 if line[index] == "1"
    end
    common = oxygen_amount.to_f / oxygen_numbers.size >= 0.5 ? "1" : "0"
    oxygen_numbers = oxygen_numbers.select {|number| number[index] == common }
  end
  if co_numbers.size > 1
    co_amount = 0
    co_numbers.each do |line|
      co_amount += 1 if line[index] == "1"
    end
    uncommon = co_amount.to_f / co_numbers.size >= 0.5 ? "0" : "1"
    co_numbers = co_numbers.select {|number| number[index] == uncommon }
  end
end
puts oxygen_numbers.first.to_i(2) * co_numbers.first.to_i(2)