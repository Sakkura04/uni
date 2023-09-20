# Визначимо пріоритети операцій
operat_prior = { "+" => 1, "-" => 1, "*" => 2, "/" => 2, "^" => 3 }

# Ініціалізуємо списки для виводу і стеку
output = []
stack = []

# Зчитуємо вхідну стрічку від користувача
input = gets.chomp.to_s

# Розбиваємо вхідну стрічку на токени
tokens = input.split(/ */)

# Ітеруємося через токени
tokens.each do |token|
  if token.match?(/\d+/)
    # Якщо токен є числом, додаємо його до виводу
    output.push(token)
  elsif token == "("
    stack.push(token)
  elsif token == ")"
    # Якщо токен - закриваюча дужка, виводимо операції зі стеку до відкриваючої дужки
    output.push(stack.pop) while stack.last != "("
    stack.pop  # Видаляємо відкриваючу дужку зі стеку
  else
    # Якщо токен - операція, виводимо операції зі стеку з більшим чи рівним пріоритетом
    while !stack.empty? && operat_prior[token] <= operat_prior[stack.last].to_i
      output.push(stack.pop)
    end
    stack.push(token)
  end
end

# Додаємо залишкові операції зі стеку до виводу
output.concat(stack.reverse)

# Виводимо результат
puts output.join(' ')
