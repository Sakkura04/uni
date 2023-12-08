MY_CONSTANT = 50 # константа

def example_method
  x = 10 # локальна змінна
  puts x
  $global_var = 20 # глобальна змінна
end


class ExampleClass
  @@class_var = 40 # змінна класу

  def initialize(vars)
    @instance_var = vars # інстанс змінна
  end

  def print_instance_var
    puts @instance_var
  end

  def print_class_var
    puts @@class_var
  end
end


example_object = ExampleClass.new(10)
example_object2 = ExampleClass.new(5)

example_object.print_instance_var # виведе 10
example_object.print_class_var # виведе 40

example_object2.print_instance_var # виведе 5
example_object2.print_class_var # виведе 40

example_method
puts $global_var
puts MY_CONSTANT
