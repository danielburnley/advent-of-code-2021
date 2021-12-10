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

  def get(x:,y:)
    grid[y][x]
  end

  def adjacent(x:, y:)
  end

  private

  attr_reader :grid
end

input = get_example_input_for_day(day: 9).map { |line| line.split("").map(&:to_i) }
grid = CoordinateGrid.new(input)

p grid.get(x: 0, y: 0)
