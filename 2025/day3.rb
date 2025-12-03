
require 'debug' 

def calculate_max_joltage(joltages, length)
  return "" if length.zero?

  available_joltages = joltages[..-length]

  max_available_joltage = available_joltages.max

  next_available_joltage_index = available_joltages.index(max_available_joltage) + 1

  remaining_joltages = joltages[next_available_joltage_index..]

  max_available_joltage.to_s + calculate_max_joltage(remaining_joltages, length - 1)
end

path = File.join(File.dirname(__FILE__), 'day3.txt')

puts File.readlines(path, chomp: true).sum { |joltages| calculate_max_joltage(joltages.chars, 12).to_i }
