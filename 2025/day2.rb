path = File.join(File.dirname(__FILE__), 'day2.txt')

ranges = File.read(path).split(',').map do |range|
  lower, upper = range.split('-').map(&:to_i)

  Range.new(lower, upper)
end

def count?(string)
  mid = string.length / 2

  chars = string.chars 

  mid.downto(1) do |i| 
    return true if chars.each_slice(i).uniq.one?
  end

  false
end

total = ranges.sum do |range|
  range.sum do |number|
    count?(number.to_s) ? number : 0 
  end
end

puts total

