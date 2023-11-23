class DynamicMethodsExample < Hash
  def method_missing(method_name, *args, &block)
    return "Calling #{method_name} dynamically!" if method_name.to_s.start_with?('dynamic_method_')
    return make_hashik(method_name, *args) if method_name.end_with?('=')
    return self[method_name] if self.has_key?(method_name)

    super
  end

  private
  def make_hashik(method_name, *args)
    key = method_name.to_s.delete_suffix('=')
    self[key.to_sym] = args[0]
  end
end

obj = DynamicMethodsExample.new
p obj.dynamic_method_hello
obj.hi= 'Hi peaches!'
p obj.hi
