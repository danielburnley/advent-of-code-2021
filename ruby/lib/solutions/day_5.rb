require_relative '../helpers'
require 'pry'

input = get_input_for_day(day: 5)
PART_B = true

def add_to_pipes(pipes, coords)
  x, y = coords
  if(pipes[y])
    if(pipes[y][x])
      pipes[y][x] = pipes[y][x] + 1
    else
      pipes[y][x] = 1
    end
  else
    pipes[y] = {}
    pipes[y][x] = 1
  end

  pipes
end

def get_range(from, to)
  if(from > to)
    return (to..from).map { |i| i }.reverse
  end

  (from..to).map { |i| i }
end

def draw_pipes(pipes)
  max_y = pipes.keys.max
  max_x = pipes.values.map { |line| line.keys }.flatten.max
  lines = []
  (0..max_y).each do |y|
    line = []
    if(pipes[y])
      (0..max_x).each do |x|
        if(pipes[y][x])
          line << pipes[y][x]
        else
          line << "."
        end
      end
    else
      (0..max_x).each { |_| line << "."}
    end

    lines << line.join("")
  end

  puts lines.join("\n")
end

#################
pipes = {}

input.map! {|line| line.split("->").map { |l| l.split(",").map(&:strip).map(&:to_i) } }

input.each do |from, to|
  f_x, f_y = from
  t_x, t_y = to
  range = []
  if(f_x == t_x)
    start, ending = [f_y, t_y].sort
    (start..ending).each do |y|
      pipes = add_to_pipes(pipes, [f_x, y])
    end
  elsif(f_y == t_y)
    start, ending = [f_x, t_x].sort
    (start..ending).each do |x|
      pipes = add_to_pipes(pipes, [x, t_y])
    end
  else
    next unless PART_B
    x_range = get_range(f_x, t_x)
    y_range = get_range(f_y, t_y)
    coords = []
    
    x_range.each_with_index do |x, index|
      coords << [x, y_range[index]]
    end

    coords.each do |coord|
      pipes = add_to_pipes(pipes, coord)
    end
  end
end

vals = pipes.values.map do |line|
  line.values.select { |i| i > 1 }.count
end

p vals.sum