require_relative '../helpers'

def get_high_and_low(input)
  if(input.count("0") > input.count("1"))
    return ["0", "1"]
  else
    return ["1", "0"]
  end
end

def get_input_by_column(input)
  input_by_column = Array.new(input[0].length) { [] }
  input.each do |i|
    i.split("").each_with_index do |ch, index|
      input_by_column[index] << ch
    end
  end
  input_by_column
end

input = get_input_for_day(day: 3)
input_by_column = Array.new(input[0].length) { [] }
input.each do |i|
  i.split("").each_with_index do |ch, index|
    input_by_column[index] << ch
  end
end

# Part a


part_a = input_by_column.map do |r|
  get_high_and_low(r)
end.reduce(["",""]) do |out, vals|
  out[0] << vals[0]
  out[1] << vals[1]
  out
end

p part_a[0].to_i(2) * part_a[1].to_i(2)

# Part b

oxy = input.dup

count = 0
while(oxy.length > 1)
  input_by_column = get_input_by_column(oxy)
  most_common = get_high_and_low(input_by_column[count])[0]
  oxy.select! {|i| i[count] == most_common }
  count += 1
end

co2 = input.dup
count = 0
while(co2.length > 1)
  input_by_column = get_input_by_column(co2)
  most_common = get_high_and_low(input_by_column[count])[0]
  co2.reject! {|i| i[count] == most_common }
  count += 1
end

p oxy[0].to_i(2) * co2[0].to_i(2)
