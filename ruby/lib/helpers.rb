require_relative 'solution_fetcher'

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

  puzzle_input
end
