## Run with 'ruby second.rb input.txt'

def calculate_value(type_number, value_array)
  case type_number
  when 0
    value_array.sum
  when 1
    value_array.inject(:*)
  when 2
    value_array.min
  when 3
    value_array.max
  when 5
    first, second = value_array
    first > second ? 1 : 0
  when 6
    first, second = value_array
    first < second ? 1 : 0
  when 7
    first, second = value_array
    first == second ? 1 : 0
  end
end

def calculate_number(binary)
  number = ""
  digit_count = 1
  while true
    number += binary[(7 + (digit_count - 1) * 5)..(5 + digit_count * 5)]
    if binary[6 + (digit_count - 1) * 5] && binary[6 + (digit_count - 1) * 5] == "1"
      digit_count += 1
    else
      break
    end
  end
  number = number.to_i(2)
  remaining_binary = binary[(6 + digit_count * 5)..]
  [number, remaining_binary]
end

def sub_packets_array(binary)
  return [] if binary.nil? || binary.empty? || binary.size < 7

  type_number = binary[3..5].to_i(2)

  if type_number == 4
    number, remaining_binary = calculate_number(binary)

    return [number] + sub_packets_array(remaining_binary)
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sub_packet_binary = binary[22..(22+sub_packet_length-1)]
      remaining_binary = binary[22+sub_packet_length..]
      sub_packet_array = sub_packets_array(sub_packet_binary)
      next_values_array = sub_packets_array(remaining_binary)

      return [calculate_value(type_number, sub_packet_array)] + next_values_array
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_packet_binary = binary[18..]
      sub_packet_array, next_binary = sub_packets_array_with_packet_limit(sub_packet_binary, sub_packet_limit)
      next_values_array = sub_packets_array(next_binary)

      return [calculate_value(type_number, sub_packet_array)] + next_values_array
    end
  end
end

def sub_packets_array_with_packet_limit(binary, limit)
  return [[], binary] if limit == 0
  limit -= 1
  type_number = binary[3..5].to_i(2)

  if type_number == 4
    number, remaining_binary = calculate_number(binary)
    number_array, next_binary = sub_packets_array_with_packet_limit(remaining_binary, limit)

    return [[number] + number_array, next_binary]
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sub_packet_binary = binary[22..(22+sub_packet_length-1)]
      next_binary = binary[22+sub_packet_length..]
      sub_packet_array = sub_packets_array(sub_packet_binary)
      next_values_array, remaining_binary = sub_packets_array_with_packet_limit(next_binary, limit)

      return [[calculate_value(type_number, sub_packet_array)] + next_values_array, remaining_binary]
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_packet_binary = binary[18..]
      sub_packet_array, next_binary = sub_packets_array_with_packet_limit(sub_packet_binary, sub_packet_limit)
      next_values_array, remaining_binary = sub_packets_array_with_packet_limit(next_binary, limit)

      return [[calculate_value(type_number, sub_packet_array)] + next_values_array, remaining_binary]
    end
  end
end

def calculate_result(binary)
  type_number = binary[3..5].to_i(2)

  if type_number == 4
    number, _remaining_binary = calculate_number(binary)
    return number
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sub_packets_binary = binary[22..(22+sub_packet_length-1)]
      return_array = sub_packets_array(sub_packets_binary)

      return calculate_value(type_number, return_array)
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_packets_binary = binary[18..]
      return_array, _remaining_binary = sub_packets_array_with_packet_limit(sub_packets_binary, sub_packet_limit)

      return calculate_value(type_number, return_array)
    end
  end
end

hex = File.read(ARGV[0]).strip
binary = hex.chars.sum("") do |hex_char|
  "%04d" % hex_char.to_i(16).to_s(2)
end
puts calculate_result(binary)