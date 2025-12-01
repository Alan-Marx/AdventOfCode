class Dial 
  attr_reader :history

  def initialize(values, pointer: nil)
    @history = []
    @pointer = pointer || 0
    @values  = values.to_a
    @total_values = values.count
  end

  def current_value 
    @values[@pointer]
  end

  def turn_right(turns)
    turn(turns) do
      @pointer = (@pointer + 1) % @total_values
    end
  end

  def turn_left(turns)
    turn(turns) do
      @pointer = (@pointer - 1) % @total_values
    end
  end

  private

  def turn(turns, &block) 
    raise ArgumentError unless turns.positive?

    turns.times do |turn|  
      yield 

      @history << current_value
    end
  end 
end

class Rotation 
  def initialize(value)
    @value = value
  end

  def direction 
    @value.start_with?('L') ? :left : :right
  end

  def turns 
    @value[1..].to_i
  end
end

dial = Dial.new(0..99, pointer: 50)

File.readlines('dial_instructions.txt', chomp: true).each do |rotation|
  rotation = Rotation.new(rotation) 

  dial.public_send("turn_#{rotation.direction}", rotation.turns) 
end

puts dial.history.count(0)