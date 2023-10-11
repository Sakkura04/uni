
def roman_to_int(roman)
  rom_script = {
    'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000
  }

  result = 0
  prev_value = 0

  roman.reverse.each_char do |char|
    value = rom_script[char]
    if !value
      puts "Wrong symbol: #{char}"
      return
    end

    if value < prev_value
      result -= value
    else
      result += value
    end

    prev_value = value
  end

  result
end


def int_to_roman(num)
  roman_numerals = {
    1000 => 'M', 900 => 'CM', 500 => 'D', 400 => 'CD',
    100 => 'C', 90 => 'XC', 50 => 'L', 40 => 'XL',
    10 => 'X', 9 => 'IX', 5 => 'V', 4 => 'IV', 1 => 'I'
  }

  roman = ''

  roman_numerals.each do |value, symbol|
    while num >= value
      roman += symbol
      num -= value
    end
  end

  roman
end


# Приклади використання
while true
  puts("\nTo enter romanian num - press 1\nto enter arabian - 2\nto exit - 0")
  option = gets().chomp.to_i
  if option == 0
    puts("Byeeee")
    break
  end

  if option == 1
    puts("Enter romanian num")
    num = gets().chomp
    puts roman_to_int(num)
  end

  if option == 2
    puts("Enter arabian num")
    num = gets().chomp.to_i
    puts int_to_roman(num)
  end
end

# MMVIII - 2008
# 4 IV
# 19990 MCMXC
