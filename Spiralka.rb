def create_spiral_matrix(n)
  # Створюємо пусту матрицю розміром n x n
  matrix = Array.new(n) { Array.new(n, 0) }

  # Початкові значення та межі для руху
  num = n * n
  top, bottom, left, right = 0, n - 1, 0, n - 1

  while num >= 1
    # Заповнюємо верхню горизонтальну лінію зліва направо
    for i in left..right
      matrix[top][i] = num
      num -= 1
    end
    top += 1

    # Заповнюємо праву вертикальну лінію зверху вниз
    for i in top..bottom
      matrix[i][right] = num
      num -= 1
    end
    right -= 1

    # Заповнюємо нижню горизонтальну лінію справа наліво
    for i in right.downto(left)
      matrix[bottom][i] = num
      num -= 1
    end
    bottom -= 1

    # Заповнюємо ліву вертикальну лінію знизу вгору
    for i in bottom.downto(top)
      matrix[i][left] = num
      num -= 1
    end
    left += 1
  end

  return matrix
end

puts "Введіть розмір матриці (n x n):"
n = gets.chomp.to_i

if n <= 0
  puts "Розмір матриці повинен бути більше 0."
else
  spiral_matrix = create_spiral_matrix(n)

  puts "Спіральна матриця #{n} x #{n}:"
  spiral_matrix.each { |row| puts row.join("\t") }
end
