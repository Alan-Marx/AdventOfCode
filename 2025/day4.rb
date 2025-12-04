require 'debug'

def extract_paper_rolls(grid)
  paper_rolls = {}

  grid.each_with_index do |row, row_number|
    row.each_with_index do |cell, column_number|
      paper_rolls[[row_number, column_number]] = 0 if cell == '@'
    end
  end

  paper_rolls
end

def add_neighbours_to_paper_rolls(paper_rolls, grid)
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
        paper_rolls[paper_roll] += 1 if paper_rolls.key?(paper_roll)
      end
    end
  end
end

def remove_paper_rolls(paper_rolls, grid)
  paper_rolls.each do |paper_roll, _neighbours|
    grid[paper_roll[0]][paper_roll[1]] = '.'
  end
end

def count_movable_paper_rolls(grid)
  paper_rolls = extract_paper_rolls(grid)

  add_neighbours_to_paper_rolls(paper_rolls, grid)

  countable_paper_rolls = paper_rolls.select { |_paper_roll, neighbours| neighbours < 4 }

  return 0 if countable_paper_rolls.empty?

  remove_paper_rolls(countable_paper_rolls, grid)

  countable_paper_rolls.count + count_movable_paper_rolls(grid)
end

grid = File.readlines(File.join(__dir__, 'day4.txt'), chomp: true).collect(&:chars)

puts count_movable_paper_rolls(grid)

