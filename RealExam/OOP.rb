class Animal
  protected #інкапсуляція
  def sound
    puts "Animal makes a sound"
  end
end

class Dog < Animal # спадкування
  def sound # поліморфізм
    puts "Dog barks"
  end
end

class Cat < Animal # спадкування
  def sound # поліморфізм
    puts "Cat meows"
  end
end

animal = Animal.new
dog = Dog.new
cat = Cat.new

dog.sound
cat.sound

begin
  animal.sound # Видасть помилку, оскільки метод sound має захищений доступ
rescue
  puts "Error: Cannot access sound method on Animal"
end

