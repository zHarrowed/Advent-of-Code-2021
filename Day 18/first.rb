## Run with 'ruby first.rb input.txt'

def sum_snail_numbers(number_1, number_2)
  if number_1.nil?
    number_2
  elsif number_2.nil?
    number_1
  else
    reduce_snail_number([number_1, number_2])
  end
end

def reduce_snail_number(snail_number)
  while (exploding_needed = snail_number_needs_exploding?(snail_number)) || (splitting_needed = snail_number_needs_splitting?(snail_number))
    if exploding_needed
      _exploded, _left_value, new_number, _right_value = explode_snail_number(snail_number, 1)
      snail_number = new_number
    elsif splitting_needed
      _split_done, new_number = split_snail_number(snail_number)
      snail_number = new_number
    end
  end
  snail_number
end

def snail_number_needs_exploding?(snail_number)
  snail_number.flatten(3) != snail_number.flatten(4)
end

def snail_number_needs_splitting?(snail_number)
  snail_number.flatten.max > 9
end

def explode_snail_number(snail_number, level)
  if level <= 4 || snail_number.find { _1.kind_of?(Array) }
    number_1, number_2 = snail_number
    exploded = false
    if number_1.kind_of?(Array)
      exploded, left_value, new_number, right_value = explode_snail_number(number_1, level + 1)
      if exploded
        number_1 = new_number
        number_2 = right_value ? add_to_first(number_2, right_value) : number_2
        if left_value
          return [exploded, left_value, [number_1, number_2], nil]
        end
      end
    end
    if number_2.kind_of?(Array) && !exploded
      exploded, left_value, new_number, right_value = explode_snail_number(number_2, level + 1)
      if exploded
        number_1 = left_value ? add_to_first_on_right(number_1, left_value) : number_1
        number_2 = new_number
        if right_value
          return [exploded, nil, [number_1, number_2], right_value]
        end
      end
    end
    return [exploded, nil, [number_1, number_2], nil]
  else
    number_1, number_2 = snail_number
    [true, number_1, 0, number_2]
  end
end

def add_to_first(snail_number, value)
  if snail_number.kind_of?(Integer)
    snail_number + value
  else
    number_1, number_2 = snail_number
    [add_to_first(number_1, value), number_2]
  end
end

def add_to_first_on_right(snail_number, value)
  if snail_number.kind_of?(Integer)
    snail_number + value
  else
    number_1, number_2 = snail_number
    [number_1, add_to_first_on_right(number_2, value)]
  end
end

def split_snail_number(snail_number)
  number_1, number_2 = snail_number
  if number_1.kind_of?(Array)
    splitting_done, new_number = split_snail_number(number_1)
    number_1 = new_number
  elsif number_1 > 9
    number_1 = [(number_1 / 2.0).floor, (number_1 / 2.0).ceil]
    splitting_done = true
  else
    splitting_done = false
  end
  unless splitting_done
    if number_2.kind_of?(Array)
      splitting_done, new_number = split_snail_number(number_2)
      number_2 = new_number
    elsif number_2 > 9
      number_2 = [(number_2 / 2.0).floor, (number_2 / 2.0).ceil]
      splitting_done = true
    else
      splitting_done = false
    end
  end
  [splitting_done, [number_1, number_2]]
end

def calculate_magnitude(snail_number)
  number_1, number_2 = snail_number
  magnitude_1 = number_1.kind_of?(Array) ? calculate_magnitude(number_1) : number_1
  magnitude_2 = number_2.kind_of?(Array) ? calculate_magnitude(number_2) : number_2
  (3 * magnitude_1) + (2 * magnitude_2)
end

snail_numbers = File.read(ARGV[0]).lines.map{|snail_number| eval(snail_number.strip)}
result_snail_number = snail_numbers.inject(nil) { sum_snail_numbers(_1, _2) }

puts calculate_magnitude(result_snail_number)