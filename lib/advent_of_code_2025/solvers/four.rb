# Solver implementation for Day 4 of Advent of Code 2025.
class AdventOfCode2025::Solvers::Four < AdventOfCode2025::Solvers::Base
  PAPER_ROLL = "@".freeze

  def initialize(input)
    super(input)
    @data_grid = @input.each_line.map { |line| line.chomp.chars }
    @initial_grid = @data_grid.map(&:dup)
    @data = { initial_grid: @initial_grid, events: [] }
  end

  private

  def solve_part_1
    updated_data_grid = @data_grid.map(&:clone)

    # Use level 0 for solve_part_1
    process_grid(@data_grid, updated_data_grid, level: 0)
  end

  def solve_part_2
    updated_data_grid = @data_grid.map(&:clone)

    stil_rols_to_move = true
    total_rols_moved = 0
    level = 0

    while stil_rols_to_move
      # Create a new level for each while iteration
      rols_available_to_move = process_grid(@data_grid, updated_data_grid, level: level)

      @data_grid = updated_data_grid.map(&:clone)
      total_rols_moved += rols_available_to_move
      stil_rols_to_move = rols_available_to_move.positive?
      level += 1
    end

    total_rols_moved
  end

  def process_grid(data_grid, updated_data_grid, level:)
    rols_available_to_move = 0

    # First find all moves using the current grid so adjacency checks are stable.
    movable_positions = []
    data_grid.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        next unless cell == PAPER_ROLL
        next unless count_adjacent_paper_rolls(data_grid, row_index, col_index) < 4

        movable_positions << [row_index, col_index]
      end
    end

    movable_positions.each do |row_index, col_index|
      updated_data_grid[row_index][col_index] = "X" # Mark as moved
      rols_available_to_move += 1
      @data[:events] << { row: row_index, col: col_index, rolls_moved: rols_available_to_move, level: level }
    end

    rols_available_to_move
  end

  def count_adjacent_paper_rolls(data_grid, row_index, col_index)
    directions = {
      up_left: [-1, -1], up: [-1, 0], up_right: [-1, 1],
      left: [0, -1], right: [0, 1],
      down_left: [1, -1], down: [1, 0], down_right: [1, 1]
    }

    directions.count do |_direction, (d_row, d_col)|
      new_row = row_index + d_row
      new_col = col_index + d_col
      # To be sure we are within bounds and avoid out-of-bounds errors
      new_row.between?(0, data_grid.length - 1) &&
        new_col.between?(0, data_grid[new_row].length - 1) &&
        data_grid[new_row][new_col] == PAPER_ROLL
    end
  end
end
