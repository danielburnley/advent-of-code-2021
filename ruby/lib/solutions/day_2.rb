require_relative '../helpers'

input = get_input_for_day(day: 2).map do |line|
  instruction = line.split(" ")
  instruction[1] = instruction[1].to_i
  instruction
end

horizontal = 0
depth = 0

input.each do |instruction|
  if instruction[0] == "forward"
    horizontal += instruction[1]
  elsif instruction[0] == "down"
    depth += instruction[1]
  elsif instruction[0] == "up"
    depth -= instruction[1]
  end
end

puts horizontal * depth

horizontal = 0
depth = 0
aim = 0

input.each do |instruction|
  if instruction[0] == "forward"
    horizontal += instruction[1]
    depth += instruction[1] * aim

  elsif instruction[0] == "down"
    aim += instruction[1]
  elsif instruction[0] == "up"
    aim -= instruction[1]
  end
end

puts horizontal * depth
