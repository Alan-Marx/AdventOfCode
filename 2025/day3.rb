
require 'debug' 

class BatteryBank 
  attr_reader :joltages 

  def initialize(joltages)
    @joltages = joltages.chars
  end

  def maximum_joltage
    first_joltage = joltages[..-2].max

    first_joltage_index = joltages.index(first_joltage)

    second_joltage = joltages[(first_joltage_index + 1)..].max 

    "#{first_joltage}#{second_joltage}".to_i
  end
end

path = File.join(File.dirname(__FILE__), 'day3.txt')

battery_banks = File.readlines(path, chomp: true).collect { |line| BatteryBank.new(line) }

puts battery_banks.sum(&:maximum_joltage)