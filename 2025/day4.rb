require 'debug'

grid = File.readlines(File.join(__dir__, 'day4.txt'), chomp: true).collect(&:chars)

paper_roll_neighbour_count = {}

grid.each_with_index do |row, row_number|
  row.each_with_index do |cell, column_number|
    paper_roll_neighbour_count[[row_number, column_number]] = 0 if cell == '@'
  end
end

grid.each_with_index do |row, row_number|
  row.each_with_index do |cell, column_number|
    next if cell != '@'

    [ 
      # row above
      [row_number - 1, column_number],
      [row_number - 1, column_number - 1],
      [row_number - 1, column_number + 1],
       # same row
      [row_number, column_number - 1],
      [row_number, column_number + 1],
      # row below
      [row_number + 1, column_number],
      [row_number + 1, column_number - 1],
      [row_number + 1, column_number + 1],
    ].each do |paper_roll|
      paper_roll_neighbour_count[paper_roll] += 1 if paper_roll_neighbour_count.key?(paper_roll)
    end
  end
end

puts paper_roll_neighbour_count.count { |_paper_roll_position, neighbours| neighbours < 4 }

