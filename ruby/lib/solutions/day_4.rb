require_relative '../helpers'

input = get_input_for_day(day: 4)

def print_board(board)
  puts board.map { |l| l.map {|n| n[0]}.join(",") }.join("\n")
end

def print_board_state(board)
  puts board.map { |l| l.map{|n| n.join(",") }.join("|") }.join("\n")
end

def draw_number(board, number)
  board.map do |line|
    line.map do |square,drawn|
      if(number == square)
        [square, true]
      else
        [square, drawn]
      end
    end
  end
end

def check_rows(board)
  board.any? do |row|
    row.all? { |n| n[1] }
  end
end

def check_cols(board)
  cols = []
  board[0].each_with_index do |_, index|
    cols << board.map { |row| row[index] }
  end
  cols.any? { |col| col.all? { |n| n[1] } }
end

def total_not_drawn(board)
  board.map do |line|
    line.select {|n| n[1] == false}.map {|n| n[0].to_i }.sum
  end.sum
end

drawn_numbers = input[0]
board_input = input[2..-1].map { |line| line.split(" ").map{ |n| [n, false] } }
boards = []
current_board = []

board_input.each do |line|
  if(line.empty?)
    boards << current_board
    current_board = []
  else
    current_board << line
  end
end
boards << current_board

winning_boards = []

drawn_numbers.split(",").each do |drawn|
  boards = boards.map { |board| draw_number(board, drawn) }
  p boards.count
  row_winners = boards.select { |board| check_rows(board) }
  col_winners = boards.select { |board| check_cols(board) }
  
  if(row_winners.any?)
    row_winners.each do |row_winner|
      winning_boards << [drawn, row_winner.dup]
      boards.delete(row_winner)
    end
  end

  if(col_winners.any?)
    col_winners.each do |col_winner|
      winning_boards << [drawn, col_winner.dup]
      boards.delete(col_winner)
    end
  end
end

p winning_boards[0][0].to_i * total_not_drawn(winning_boards[0][1])
p winning_boards[-1][0].to_i * total_not_drawn(winning_boards[-1][1])
print_board_state(winning_boards[-1][1])