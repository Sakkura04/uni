def generate_password(length)
  # Можлими символи для паролю
  characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'

  # Ініціалізуємо порожній рядок для паролю
  password = ''

  # Генеруємо випадковий пароль
  length.times do
    random_index = rand(characters.length)
    password << characters[random_index]
  end

  return password
end



while true
  puts("\nTo generate password - press 1\nto exit - 0")
  option = gets().chomp.to_i
  if option == 0
    puts("Byeeee peach")
    break
  end

  if option == 1
    puts("Enter length of password")
    length = gets().chomp.to_i
    random_password = generate_password(length)
    puts "Згенерований пароль: #{random_password}"
  end
end
