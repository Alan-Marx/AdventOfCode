require 'debug'

data = File.readlines(File.join(__dir__, 'day5.txt'), chomp: true)

ranges, ids = data.partition { |line| line.include?("-") }

ranges.collect! { |range| Range.new(*range.split("-").collect(&:to_i)) }

puts (ids.collect(&:to_i).count do |id|
  ranges.any? { |range| range.include?(id) }
end)
