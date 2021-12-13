require_relative '../helpers'
require 'pry'

class CoordinateGrid
  def initialize(input)
    @grid = {}
    input.each_with_index do |line, y|
      line.each_with_index do |val, x|
        if !@grid[y]
          @grid[y] = {}
        end

        @grid[y][x] = val
      end
    end
  end

  def get(x,y)
    if grid[y]
      return grid[y][x]
    end
    nil
  end

  def adjacent_values(x, y)
    [get(x,y-1), get(x,y+1), get(x-1,y), get(x+1,y)].compact
  end

  def adjacent_positions(x, y)
    positions = [[x,y-1],[x,y+1],[x-1,y],[x+1,y]]
    positions.select { |p| get(p[0], p[1]) }
  end

  def all_positions
    res = []

    grid.each do |y, rows|
      rows.each do |x, _|
        res << [x,y]
      end
    end

    res
  end

  private

  attr_reader :grid
end

input = get_input_for_day(day: 9).map { |line| line.split("").map(&:to_i) }
grid = CoordinateGrid.new(input)

# Part A

total_risk = grid.all_positions.sum do |pos|
  x,y = pos
  val = grid.get(x,y)
  if grid.adjacent_values(x,y).all? { |n| n > val }
    val + 1
  else
    0
  end
end

p "Part A"
p total_risk

# Part B

already_checked = []
basins = []
current_basin = []

grid.all_positions.each do |pos|
  p already_checked.length
  x,y = pos
  next if grid.get(x,y) == 9
  next if already_checked.include?(pos)

  current_basin << pos
  to_check = grid.adjacent_positions(x,y)
  next_check = []

  while to_check.count > 0
    to_check.reject {|p| already_checked.include?(p) }.each do |check_pos|
      next if already_checked.include?(check_pos)
      already_checked << check_pos

      c_x, c_y = check_pos
      next if grid.get(c_x, c_y) == 9
      grid.adjacent_positions(c_x, c_y).each {|p| next_check << p }
      current_basin << check_pos
    end
    to_check = next_check.dup
    next_check = []
  end
  basins << current_basin.dup
  current_basin = []
end

p basins.map(&:uniq).map(&:count).sort.reverse[0..2].reduce(1) { |res,b| res * b }
