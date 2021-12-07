require_relative '../helpers'
require 'pry'

input = get_input_for_day(day: 7)
crabs = input[0].split(",").map(&:to_i)

# part one

res = (crabs.min..crabs.max).map do |i|
  { position: i, fuel: crabs.map { |c| (c - i).abs }.sum }
end

min_fuel = res.min_by do |r|
  r[:fuel]
end

p min_fuel

# part two

res = (crabs.min..crabs.max).map do |i|
  fuel_counts = crabs.map do |c|
    min, max = [c, i].sort
    if min > 0
      max = max - min
      min = 0
    end

    (min..max).sum
  end
  { position: i, fuel: fuel_counts.sum }
end

min_fuel = res.min_by do |r|
  r[:fuel]
end

p min_fuel
