class Shape
  def area
    raise NotImplementedError, "Subclasses must implement the 'area' method."
  end
end

class Square < Shape
  def initialize(side_length)
    @side_length = side_length
  end

  def area
    @side_length**2
  end
end

class Circle < Shape
  def initialize(radius)
    @radius = radius
  end

  def area
    Math::PI * @radius**2
  end
end

def print_area(shape)
  puts "Area: #{shape.area}"
end

square = Square.new(4)
circle = Circle.new(3)

print_area(square) # Виводить: Area: 16
print_area(circle) # Виводить: Area: 28.274333882308138
