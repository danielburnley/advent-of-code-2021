require_relative '../helpers'
require 'pry'

input = get_input_for_day(day: 6)
initial_timers = input[0].split(",").map(&:to_i)
timers = {}

initial_timers.uniq.each do |i|
  timers[i] = initial_timers.count(i)
end


def tick_b(timers) 
  new_fish = 0
  timers2 = {}
  (0..8).each {|i| timers2[i] = 0}

  timers.each do |k,v|
    if k == 0
      new_fish = v
      timers2[6] += v
    else
      if(v > 0)
        timers2[k-1] += v
      end
    end
  end

  timers2[8] = new_fish

  timers2
end


timers_a = timers.dup
80.times do
  timers_a = tick_b(timers_a)
end

p "Part a:"
p timers_a.values.sum

256.times do |i|
  timers = tick_b(timers)
end

p "Part b:"
p timers.values.sum
