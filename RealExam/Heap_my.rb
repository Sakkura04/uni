class MinHeap
  attr_reader :heap

  def initialize
    @heap = []
  end

  def push(value)
    @heap << value
    heapify_up if (self.peek).is_a?(Integer)
  end

  def pop
    return nil if empty?

    swap(0, @heap.length - 1)
    min_value = @heap.pop
    heapify_down if (self.peek).is_a?(Integer)

    min_value
  end

  def peek
    @heap[0]
  end

  def size
    @heap.length
  end

  def empty?
    @heap.empty?
  end

  private

  def heapify_up
    index = @heap.length - 1

    while has_parent?(index) && parent(index) > @heap[index]
      swap(index, parent_index(index))
      index = parent_index(index)
    end
  end

  def heapify_down
    index = 0

    while has_left_child?(index)
      smaller_child_index = left_child_index(index)
      if has_right_child?(index) && right_child(index) < left_child(index)
        smaller_child_index = right_child_index(index)
      end

      break if @heap[index] < @heap[smaller_child_index]

      swap(index, smaller_child_index)
      index = smaller_child_index
    end
  end

  def has_parent?(index)
    index > 0
  end

  def parent_index(index)
    (index - 1) / 2
  end

  def parent(index)
    @heap[parent_index(index)]
  end

  def has_left_child?(index)
    left_child_index(index) < @heap.length
  end

  def left_child_index(index)
    2 * index + 1
  end

  def left_child(index)
    @heap[left_child_index(index)]
  end

  def has_right_child?(index)
    right_child_index(index) < @heap.length
  end

  def right_child_index(index)
    2 * index + 2
  end

  def right_child(index)
    @heap[right_child_index(index)]
  end

  def swap(index1, index2)
    temp = @heap[index1]
    @heap[index1] = @heap[index2]
    @heap[index2] = temp
  end
end


# Функція пошуку мін елементу
def find_k_smallest_elements(arr, k)
  min_heap = MinHeap.new
  arr.each { |element| min_heap.push(element) }

  result = []
  k.times { result << min_heap.pop }

  result
end


# Клас та функція для представлення купи на "живому" прикладі
# Клас для представлення завдання
class Task
  attr_reader :name, :priority

  def initialize(name, priority)
    @name = name
    @priority = priority
  end
end

# Метод для планування завдань з використанням купи
def schedule_tasks(tasks)
  # Створення порожньої купи
  heap = MinHeap.new { |task1, task2| task2.priority <=> task1.priority }

  # Додавання завдань до купи
  tasks.each { |task| heap.push(task) }

  # Виконання завдань у порядку зростання пріоритету
  while !heap.empty?
    task = heap.pop
    puts "Виконується завдання: #{task.name}, Пріоритет: #{task.priority}"
  end
end







# Приклад звичайного використання
puts 'Приклад звичайного використання купи'
heap = MinHeap.new
heap.push(4)
heap.push(10)
heap.push(3)
heap.push(5)
puts "peek: #{heap.peek}" # Виведе 3
puts "pop: #{heap.pop}" # Виведе 3
puts "peek: #{heap.peek}" # Виведе 4
puts "size: #{heap.size}"  # Виведе 3
puts "empty?: #{heap.empty?}" # Виведе false
heap.pop
heap.pop
heap.pop
puts "empty? (after pops): #{heap.empty?}\n\n" # Виведе true


# Приклад використання пошуку найм елем
puts "Приклад використання пошуку найменшого елемента\n\n"
array = [15, 13, 8, 4, 2, 31, 9]
k = 3

puts "Заданий масив: #{array}"
result = find_k_smallest_elements(array, k)
puts "Перші #{k} найменших елементів: #{result}"


# Приклад використання на простенькому органайзері завдань
puts "\n\nПриклад використання на простенькому органайзері завдань"
tasks = [
  Task.new('Завдання 1', 3),
  Task.new('Завдання 2', 1),
  Task.new('Завдання 3', 2)
]

schedule_tasks(tasks)