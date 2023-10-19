def sort_numbers(numbers, order)
  sorted_numbers = numbers.sort

  if order == 'desc'
    sorted_numbers = sorted_numbers.reverse
  end

  return sorted_numbers
end


while true
  puts("To sort nums in ascending order - press 1\n" +
         "To sort nums in descending order - press 2\nto exit - 0")
  option = gets().chomp.to_i
  if option == 0
    puts("Byeeee peach")
    break

  elsif option == 1 || option == 2
    puts("Enter numbers separated by space")
    user_input = gets.chomp
    numbers = user_input.split.map(&:to_i)
    order = option == 1 ? 'asc' : 'desc'
    sorted_numbers = sort_numbers(numbers, order)
    puts "Sorted list: #{sorted_numbers}"
    
  else
    puts("probably u have fat fingers, try again:")
  end
end


