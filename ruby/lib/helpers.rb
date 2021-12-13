require_relative 'solution_fetcher'

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

def get_example_input_for_day(day:)
  File.open("#{__dir__}/inputs/day_#{day}_example.txt", 'r') { |f| f.readlines(chomp: true) }
end

def get_input_for_day(day:)
  File.open("#{__dir__}/inputs/day_#{day}.txt", 'r') { |f| f.readlines(chomp: true) }
rescue StandardError
  puzzle_input = fetch_solution_for_day(day: day)

  File.open("#{__dir__}/inputs/day_#{day}.txt", 'w') do |f|
    f.write(puzzle_input)
  end

  File.open("#{__dir__}/inputs/day_#{day}.txt", 'r') { |f| f.readlines(chomp: true) }
end

def print_hash_coords(coords)
  max_y = coords.keys.max
  max_x = coords.values.map { |line| line.keys }.flatten.max
  lines = []
  (0..max_y).each do |y|
    line = []
    if(coords[y])
      (0..max_x).each do |x|
        if(coords[y][x])
          line << coords[y][x]
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
