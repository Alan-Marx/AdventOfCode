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
    turn(turns, 1)
  end

  def turn_left(turns)
    turn(turns, -1)
  end

  private

  def turn(turns, change) 
    raise ArgumentError unless turns.positive?

    turns.times do |turn|  
      @pointer = (@pointer + change) % @total_values

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

File.readlines('input.txt', chomp: true).each do |rotation|
  rotation = Rotation.new(rotation) 

  dial.public_send("turn_#{rotation.direction}", rotation.turns) 
end

puts dial.history.count(0)