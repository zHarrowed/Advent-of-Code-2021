## Run with 'ruby first.rb input.txt'

def enhance_image(input_image, algorithm, cycle)
  infinity_character = cycle % 2 == 0 || algorithm[0] == "." ? algorithm[0] : algorithm[511]
  input_image = enlarge_image_with(input_image, infinity_character)
  width = input_image.first.size
  height = input_image.size
  output_image = Array.new(height) { Array.new(width, ".") }
  (0..(height-1)).each do |y|
    (0..(width-1)).each do |x|
      index = []
      if y != 0 && x != 0
        index[0] = input_image[y-1][x-1] == "#" ? "1" : "0"
      else
        index[0] = infinity_character == "#" ? "1" : "0"
      end
      if y != 0
        index[1] = input_image[y-1][x] == "#" ? "1" : "0"
      else
        index[1] = infinity_character == "#" ? "1" : "0"
      end
      if y != 0 && x < (width - 1)
        index[2] = input_image[y-1][x+1] == "#" ? "1" : "0"
      else
        index[2] = infinity_character == "#" ? "1" : "0"
      end
      if x != 0
        index[3] = input_image[y][x-1] == "#" ? "1" : "0"
      else
        index[3] = infinity_character == "#" ? "1" : "0"
      end
      index[4] = input_image[y][x] == "#" ? "1" : "0"
      if x < (width - 1)
        index[5] = input_image[y][x+1] == "#" ? "1" : "0"
      else
        index[5] = infinity_character == "#" ? "1" : "0"
      end
      if y < (height - 1) && x != 0
        index[6] = input_image[y+1][x-1] == "#" ? "1" : "0"
      else
        index[6] = infinity_character == "#" ? "1" : "0"
      end
      if y < (height - 1)
        index[7] = input_image[y+1][x] == "#" ? "1" : "0"
      else
        index[7] = infinity_character == "#" ? "1" : "0"
      end
      if y < (height - 1) && x < (width - 1)
        index[8] = input_image[y+1][x+1] == "#" ? "1" : "0"
      else
        index[8] = infinity_character == "#" ? "1" : "0"
      end
      index = index.join.to_i(2)
      output_image[y][x] = algorithm[index]
    end
  end
  output_image
end

def enlarge_image_with(image, character)
  image.each do |row|
    row.prepend(character)
    row.append(character)
  end
  width = image.first.size
  image.prepend(Array.new(width, character))
  image.append(Array.new(width, character))
  image
end

input = File.read(ARGV[0])
algorithm, input_image = input.split("\n\n")
algorithm = algorithm.strip.split("")
image = input_image.lines.map { _1.strip.split("") }

2.times do |index|
  image = enhance_image(image, algorithm, index + 1)
end

puts image.sum {|row| row.sum {|pixel| pixel == "#" ? 1 : 0}}