require 'pry'
require 'set'

class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

# class Minilang
#   ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
#
#   def initialize(program)
#     @program = program
#     @register = 0
#     @stack = []
#   end
#
#   def eval
#     @program.split.each { |token| eval_token(token) }
#   rescue MinilangRuntimeError => error
#     puts error.message
#   end
#
#   private
#
#   def eval_token(token)
#
#     if ACTIONS.include?(token)
#       send(token.downcase)
#     elsif token =~ /\A[-+]?\d+\z/
#       @register = token.to_i
#     else
#       raise BadTokenError, "Invalid token: #{token}"
#     end
#   end
#
#   def push
#     @stack.push @register
#   end
#
#   def print
#     puts @register
#   end
#
#   def operate(operation)
#     @register = @register.send(operation, @stack.pop)
#   end
#
#   def pop
#     raise EmptyStackError, "Empty stack!" if @stack.empty?
#     @register = @stack.pop
#   end
#
#   def add
#     @register += pop
#   end
#
#   def div
#     @register /= pop
#   end
#
#   def mod
#     @register %= pop
#   end
#
#   def mult
#     @register *= pop
#   end
#
#   def sub
#     @register -= pop
#   end
# end

# Minilang.new('PRINT').eval
# # # 0
#
# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # # 15
#
# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # # 5
# # # 3
# # # 8
#
# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # # 10
# # # 5
#
# Minilang.new('5 PUSH POP POP PRINT').eval
# # # Empty stack!
#
# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # # 6
#
# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # # 12
#
# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # # Invalid token: XSUB
#
# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # # 8
#
# Minilang.new('6 PUSH').eval
# # # (nothing printed; no PRINT commands)

puts "FURTHER EXPLORATION"

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
    @register = 0
    @stack = []
  end

  def eval(options)
    format(@program, options).split.each { |token| eval_token(token) }
  rescue MinilangRuntimeError => error
    puts error.message
  end

  private

  def eval_token(token)

    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push @register
  end

  def print
    puts @register
  end

  def operate(operation)
    @register = @register.send(operation, @stack.pop)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div
    @register /= pop
  end

  def mod
    @register %= pop
  end

  def mult
    @register *= pop
  end

  def sub
    @register -= pop
  end
end

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100) # => 212

AREA_RECTANGLE = '%<length>d PUSH %<width>d MULT PRINT'
minilang = Minilang.new(AREA_RECTANGLE)
minilang.eval(length: 15, width: 5) # => 75
minilang.eval({length: 15, width: 5}) # => 75

SLOPE_OF_LINE = '%<x1>d PUSH %<x2>d SUB PUSH %<y1>d PUSH %<y2>d SUB DIV PRINT'
minilang = Minilang.new(SLOPE_OF_LINE)
minilang.eval({x1: 2, y1: 4, x2: 8, y2: 16}) # => 2
