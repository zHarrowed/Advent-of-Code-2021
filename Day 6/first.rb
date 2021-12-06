## Run with 'ruby first.rb input.txt'

c0, c1, c2, c3, c4, c5, c6, c7, c8 = [0,0,0,0,0,0,0,0,0]
File.read(ARGV[0]).lines.first.split(',').each do |state|
  eval("c#{state}+=1")
end
i = 0
while i < 80
  c8, c0, c1, c2, c3, c4, c5, c6, c7 = c0, c1, c2, c3, c4, c5, c6, c7+c0, c8
  i += 1
end
puts c0 + c1 + c2 + c3 + c4 + c5 + c6 + c7 + c8