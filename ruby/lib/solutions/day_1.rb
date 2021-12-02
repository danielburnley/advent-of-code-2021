require_relative '../helpers'

input = get_input_for_day(day: 1).map(&:to_i)

count = 0
last = input[0]

input.each do |i|
  if i > last
    count += 1
  end
  last = i
end

puts count

sliding_count = 0
last = input[0..2].sum

input.each_with_index do |i, index|
  window = input[index..index+2].sum

  if window > last
    sliding_count += 1
  end
  last = window

end

puts sliding_count
