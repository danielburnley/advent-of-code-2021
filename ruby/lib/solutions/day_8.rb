require_relative '../helpers'
require 'pry'

input = get_input_for_day(day: 8).map { |line| line.split("|").map { |l| l.split(" ").map(&:strip).map { |s| s.split("") } } }
input = input.map do |line|
  line.map do |group|
    group.map do |signals|
      signals.sort
    end
  end
end

# output map

#  aaaa
# b    c
# b    c
#  dddd
# e    f
# e    f
#  gggg

# 2: 1
# 3: 7
# 4: 4
# 5: 2, 3, 5
# 6: 0, 6, 9

# part a

res = input.sum { |_, digits| digits.select { |d| [2,3,4,7].include?(d.length) }.length }
p res

# part b

KNOWN_DIGIT_LENGTHS = [2,3,4,7]

def guess_digits(digits, all_numbers)
  known_digits = all_numbers.select { |s| KNOWN_DIGIT_LENGTHS.include?(s.length) }.uniq
  numbers_by_length = all_numbers.group_by { |numbers| numbers.select { |n| n.is_a?(String) }.length }

  # Get 1,4,7,8

  known_digits.each do |digit|
    if digit.length == 2
      digits[1] = digit
    elsif digit.length == 3
      digits[7] = digit
    elsif digit.length == 4
      digits[4] = digit
    elsif digit.length == 7
      digits[8] = digit
    end
  end

  # Get 6: 0, 6, 9
  numbers_by_length[6].each do |digit|
    if digits[1]
      if (digits[1] & digit).length == 1
        digits[6] = digit
      end
    end

    if digits[1] && digits[5]
      nine = (digits[1] + digits[5]).uniq.sort
      if (nine & digit).length == 6
        digits[9] = digit
      end
    end

    if digits[3]
      if (digits[3] & digit).length == 5
        digits[9] = digit
      end
    end

    if digits[4]
      case (digits[4] & digit).length
      when 4
        digits[9] = digit
      when 3
        digits[6] = digit
      end
    end

    if digits[3] && digits[4]
      nine = (digits[3] + digits[4]).uniq.sort
      if (nine & digit).length == 6
        digits[9] = digit
      end
    end

    if digits[8]
      if (digits[8] & digit).length == 6
        digits[0] = digit
      end
    end
  end

  # Get 5: 2,3,5
  numbers_by_length[5].each do |digit|
    if digits[1]
      if (digits[1] & digit).length == 2
        digits[3] = digit
      end
    end

    if digits[2]
      if (digits[2] & digit).length == 3
        digits[5] = digit
      end
    end

    if digits[4]
      if (digits[4] & digit).length == 2
        digits[2] = digit
      end
    end

    if digits[6]
      if (digits[6] & digit).length == 5
        digit[5] = digit
      end
    end

    if digits[9]
      if (digits[9] & digit).length == 5
        digit[5] = digit
      end
    end
  end

  digits.each do |k,v|
    next unless v
    digits[k] = v.select { |a| a.is_a?(String) }
  end

  digits
end

count = 0
outputs = input.map do |signals, output|
  digits = (1..9).reduce({}) { |acc, i| acc[i] = nil; acc }
  all_numbers = signals + output

  last = {}
  while(last != digits)
    last = digits.dup
    digits = guess_digits(digits, all_numbers)
  end

  p digits.select { |_,d| d == nil }

  output = output.map { |o| o.select { |s| s.is_a?(String) } }
  output = output.map { |o| digits.key(o) }.join("")
  output.to_i
end

p outputs
binding.pry
