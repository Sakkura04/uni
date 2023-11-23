# frozen_string_literal: true

class ToyStore
  def initialize
    @toys = []
  end
  def self.new_toy(meth_name)
    send(:define_method, meth_name) {
      if @toys.include?(meth_name)
        p "New version of previous toy with name #{meth_name} in a toy store"
      else
        p "New toy in a toy store #{meth_name}"
        @toys << meth_name
      end
    }
  end
end

ToyStore.new_toy('robot')
ToyStore.new_toy('megalodon')
obj = ToyStore.new
obj.robot
obj.robot
obj.megalodon