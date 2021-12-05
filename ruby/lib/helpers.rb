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
