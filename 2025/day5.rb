require 'debug'

data = File.readlines(File.join(__dir__, 'day5.txt'), chomp: true)

ranges, ids = data.partition { |line| line.include?("-") }

ranges.collect! { |range| Range.new(*range.split("-").collect(&:to_i)) }

# part 1
puts (ids.collect(&:to_i).count do |id|
  ranges.any? { |range| range.include?(id) }
end)

# part 2 
merged_ranges = ranges.reduce([]) do |merged_ranges, range|
  overlapping_ranges, non_overlapping_ranges = merged_ranges.partition do |merged_range|
    merged_range.overlap?(range)
  end

  next non_overlapping_ranges + [range] if overlapping_ranges.empty?

  merged_range = Range.new(
    [*overlapping_ranges.map(&:min), range.min].min,
    [*overlapping_ranges.map(&:max), range.max].max
  )

  non_overlapping_ranges + [merged_range]
end

puts merged_ranges.sum(&:count)