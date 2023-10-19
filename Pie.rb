def search_izum(pie, start, width, height)
  i = 1
  izum = 0

  pie.map do |subarray|
    izum += subarray.map { |str| str[start..width].count('o') }.sum
    break if i == height
    i += 1
  end
  return true if izum == 1
  false
end


def cut_pie(pie, start, ends, height)
  i = 0
  cut_pie = pie.map { |subarray| [subarray[0].dup] }  # Створюємо глибокі копії підмасивів
  piece = []

  cut_pie.each do |subarray|
    piece[i] = []
    (start..ends).each do |index|
      piece[i] << subarray[0][index]
      subarray[0][index] = "0"
    end
    break if i == height-1
    i += 1
  end
  [cut_pie, piece]
end


def check_line(pie)
  pie.reject! { |subarray| subarray[0] =~ /\A0+\z/ }
  pie
end

def count_izum(pie)
  count = 0
  pie.each do |subarray|
    subarray[0].each_char do |char|
      count += 1 if char == "o"
    end
  end
  count
end

def total_area(arrays)
  count = 0
  arrays.each do |subarray|
    subarray.each do |string|
      count += string.count('^0')
    end
  end
  return count
end





def is_2d_array?(array)
  # Перевіряємо, чи array є екземпляром класу Array і чи його елементи також є масивами
  array.is_a?(Array) && array.all? { |subarray| subarray.is_a?(Array) }
end

def divide_rectangle(pie)
  width = pie[0][0].chars.count { |char| char != "0" }
  start = pie[0][0].chars.index { |char| char != "0" }
  height = pie.size
  num_parts = count_izum(pie)
  total_area = total_area(pie)
  part_area = total_area / num_parts.to_f

  (1..width).each do |w_part|
    h_part = part_area / w_part
    next if h_part != h_part.to_i || h_part > height

    if search_izum(pie, start, w_part + start - 1, h_part)
      res = cut_pie(pie.dup, start, w_part - 1 + start, h_part)
      pieces = res[1]
      cuted_pie = check_line(res[0])

      # puts pieces.inspect
      # puts "\n\n"
      # puts cuted_pie.inspect

      unless cuted_pie.empty?
        recurs = divide_rectangle(cuted_pie)
        if !is_2d_array?(recurs)
          # puts pie.inspect
          # puts cuted_pie.inspect
          next
        else
          pieces << recurs
        end
      end
      return pieces
    end
  end
end


def pretty_print_array(arr, indent = 0)
  arr.each do |item|
    if item.is_a?(Array)
      pretty_print_array(item, indent + 1)
    else
      puts "  " * indent + item
    end
  end
end



# puts("\nEnter your pie, to finish enter 1")
# pie = []
# while true
#   pies = gets().split("\n")
#   break if pies == ["1"]
#   pie << pies
# end

array = [["o.."], [".o."], ["..o"]]
# array = [["o..."], [".o.."], ["...."], ["o..o"], ["..o."]]
# array = [[".o.o...."], ["........"], ["....o..."], ["........"], [".....o.."], ["........"]]
res = divide_rectangle(array)
puts res.inspect
# pretty_print_array(res, depth = 1)
