## Run with 'ruby first.rb input.txt'

def sub_packets_sum(binary)
  return 0 if binary.nil? || binary.empty? || binary.size < 7

  type_number = binary[3..5].to_i(2)
  version_number = binary[0..2].to_i(2)
  if type_number == 4
    number_count = 1
    while true
      if binary[6 + (number_count - 1) * 5] && binary[6 + (number_count - 1) * 5] == "1"
        number_count += 1
      else
        break
      end
    end
    remaining_binary = binary[(6 + number_count * 5)..]
    
    return version_number + sub_packets_sum(remaining_binary)
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sub_packet_binary = binary[22..(22+sub_packet_length-1)]
      next_binary = binary[22+sub_packet_length..]
      sub_packet_sum = sub_packets_sum(sub_packet_binary)
      next_sum = sub_packets_sum(next_binary)

      return version_number + sub_packet_sum + next_sum
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_packet_binary = binary[18..]
      sub_packet_sum, next_binary = sub_packet_sum_with_packet_limit(sub_packet_binary, sub_packet_limit)
      next_sum = sub_packets_sum(next_binary)

      return version_number + sub_packet_sum + next_sum
    end
  end
end

def sub_packet_sum_with_packet_limit(binary, limit)
  return [0, binary] if limit == 0
  limit -= 1

  type_number = binary[3..5].to_i(2)
  version_number = binary[0..2].to_i(2)
  if type_number == 4
    number_count = 1
    while true
      if binary[6 + (number_count - 1) * 5] && binary[6 + (number_count - 1) * 5] == "1"
        number_count += 1
      else
        break
      end
    end
    remaining_binary = binary[(6 + number_count * 5)..]
    sum, next_binary = sub_packet_sum_with_packet_limit(remaining_binary, limit)

    return [version_number + sum, next_binary]
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sub_packet_binary = binary[22..(22+sub_packet_length-1)]
      next_binary = binary[22+sub_packet_length..]
      sub_packet_sum = sub_packets_sum(sub_packet_binary)
      next_sum, next_binary = sub_packet_sum_with_packet_limit(next_binary, limit)

      return [version_number + sub_packet_sum + next_sum, next_binary]
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_packet_binary = binary[18..]
      sub_packet_sum, next_binary = sub_packet_sum_with_packet_limit(sub_packet_binary, sub_packet_limit)
      next_sum, remaining_binary = sub_packet_sum_with_packet_limit(next_binary, limit)

      return [version_number + sub_packet_sum + next_sum, remaining_binary]
    end
  end
end

def version_number_sum(binary)
  type_number = binary[3..5].to_i(2)
  version_number = binary[0..2].to_i(2)
  if type_number == 4
    #puts "#{version_number} #{binary}"
    return version_number
  else
    length_type = binary[6].to_i
    if length_type == 0
      sub_packet_length = binary[7..21].to_i(2)
      sum = sub_packets_sum(binary[22..(22+sub_packet_length-1)])
      #puts "#{version_number} #{binary}"
      return version_number + sum
    else
      sub_packet_limit = binary[7..17].to_i(2)
      sub_sum, _remaining_binary = sub_packet_sum_with_packet_limit(binary[18..], sub_packet_limit)
      #puts "#{version_number} #{binary}"
      return version_number + sub_sum
    end
  end
end

hex = File.read(ARGV[0]).strip
binary = hex.chars.sum("") do |hex_char|
  "%04d" % hex_char.to_i(16).to_s(2)
end
puts version_number_sum(binary)