def pause_until_1
  puts "Press '1' to continue..."
  input = gets.chomp
  until input == '1'
    puts "Press '1' to continue..."
    input = gets.chomp
  end
end


def search_izum(pie, width, height)
  i = 1
  izum = 0

  pie.map do |subarray|
    izum += subarray.map { |str| str[0..width].count('o') }.sum
    break if i == height
    i += 1
  end

  return true if izum == 1
  return false
end


def cut_pie(pie, start, ends, height)
  i = 0
  piece = []

  pie.each do |subarray|
    piece[i] = []
    (start..ends).each do |index|
      piece[i] << subarray[0][index]
    end
    break if i == height-1
    i += 1
  end
  [pie, piece]
end


def check_line(pie)
  pie.reject! { |subarray| subarray[0] =~ /\A0+\z/ }
  pie
end


def divide_rectangle(pie)
  width = pie[0][0].chars.count { |char| char != "0" }
  start = pie[0][0].chars.index { |char| char != "0" }
  height = pie.size
  num_parts = pie.flatten.count {|izum| izum == "o"}
  total_area = width * height
  part_area = total_area / num_parts


  (1..width).each do |w_part|

    h_part = part_area / w_part
    next if h_part != h_part.to_i || h_part > height

    if search_izum(pie, w_part, h_part)
      res = cut_pie(pie, start, w_part, h_part)
      cuted_pie = res[0]
      pieces = res[1]
      cuted_pie = check_line(pie)
      unless cuted_pie.empty?
        pieces << divide_rectangle(cuted_pie)
      end
      return pieces
    end
  end


end


def print_divisions(divisions)
  divisions.each do |division|
    puts "Розділити на #{division.size} прямокутників:"
    division.each do |w, h|
      puts "  #{w}x#{h}"
    end
    puts
  end
end




# ....
# .o..
# ....
puts("\nEnter your pie, to finish enter 1")
pies = ""
pie = []
while true
  pies = gets().split("\n")
  break if pies == ["1"]
  pie << pies
end


# divisions = nil
#
# if (height * width) % num_parts == 0
#   divisions = divide_rectangle(pie, possible_divisions)
# end
#
# if divisions.empty?
#   puts "Неможливо розділити прямокутник на #{num_parts} частин з однаковою площею."
# else
#   print_divisions(divisions)
# end
