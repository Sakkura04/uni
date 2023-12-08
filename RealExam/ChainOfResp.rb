# frozen_string_literal: true

class Handler
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def handle_request(request)
    if @successor
      @successor.handle_request(request)
    else
      puts "Request not handled."
    end
  end
end

class CallHandler < Handler
  def handle_request(request)
    if request == 0
      puts "Bye-bye, have a nice day:)\n(CallHandler handles request #{request}.)"
    else
      super(request)
    end
  end
end

class RobotHandler < Handler
  def handle_request(request)
    if request == 1
      puts "Try to switch on/off your device, I'll wait here\n"
      sleep(5)
      puts "Is everything alright man? Press 1 if yes, 2 if no:(\n"
      request = gets().chomp.to_i
    end

    if request != 1
        super(request)
    else
      puts "RobotHandler handles request #{request}.\n"
    end
  end
end

class PersonHandler < Handler
  def handle_request(request)
    if request == 2
      puts "We'll call u in a minute."
      puts "PersonHandler handles request #{request}."
    else
      super(request)
    end
  end
end

class Client
  def self.run
    handler_a = PersonHandler.new
    handler_b = RobotHandler.new(handler_a)
    handler_с = CallHandler.new(handler_b)
    puts("If u had a problem, press - 1\nif u wanna speak just to person - 2\nto exit - 0\n")
    option = gets().chomp.to_i
    handler_с.handle_request(option)
  end
end

Client.run
