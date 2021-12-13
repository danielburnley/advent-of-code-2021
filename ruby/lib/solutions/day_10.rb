require_relative '../helpers'
require 'pry'

input = get_input_for_day(day: 10).map { |l| l.split("") }

MARKERS = [
  ["(", ")"],
  ["[", "]"],
  ["{", "}"],
  ["<", ">"]
]

MARKER_SCORES = {
  ")": 3,
  "]": 57,
  "}": 1197,
  ">": 25137
}

AUTOCOMPLETE_SCORES = {
  ")": 1,
  "]": 2,
  "}": 3,
  ">": 4
}

def opening_marks
  MARKERS.map { |m| m[0] }
end

def closing_marks
  MARKERS.map { |m| m[1] }
end

def matching_closing_mark(opening_mark)
  MARKERS.find { |m| m[0] == opening_mark }[1]
end

def is_corrupted?(line)
  stack = []

  line.each do |ch|
    if opening_marks.include?(ch)
      stack << ch
    else
      last_opening_mark = stack.pop
      if ch != matching_closing_mark(last_opening_mark)
        return {corrupted: true, error: ch}
      end
    end
  end

  {
    corrupted: false,
    autocomplete: stack.reverse.map { |ch| matching_closing_mark(ch) }
  }
end

p "Part A:"
p input.map { |line| is_corrupted?(line) }.select{ |line| line[:corrupted] }.sum { |line| MARKER_SCORES[line[:error].to_sym] }

p "Part B:"
res = input.map { |line| is_corrupted?(line) }.reject{ |line| line[:corrupted] }.map do |line|
  line[:autocomplete].reduce(0) do |score, ch|
    score = score * 5
    char_score = AUTOCOMPLETE_SCORES[ch.to_sym]
    score += char_score
    score
  end
end.sort

p res[res.count/2]
