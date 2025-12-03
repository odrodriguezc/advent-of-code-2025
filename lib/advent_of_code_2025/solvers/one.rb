
# Solves Day One of Advent of Code 2025.
#
# This class processes movement instructions on a circular track of 100 positions (0-99).
# Starting at position 50, it moves left (L) or right (R) based on input directions,
# wrapping around when reaching the boundaries.
#
# Part 1 counts how many times the position lands on zero after completing each full instruction.
# Part 2 counts how many times the position crosses zero during each individual step of movement.
#
# @example Input format
#   L10
#   R25
#   L5
#
# @return [Integer] The count of times position zero was reached, depending on the part being solved
class AdventOfCode2025::Solvers::One < AdventOfCode2025::Solvers::Base
  private

  def solve_part_1
    process_input(count_each_step: false)
  end

  def solve_part_2
    process_input(count_each_step: true)
  end

  def process_input(count_each_step:)
    start_position = 50
    position = start_position
    zero_count = 0
    update_data(position, 0, nil, zero_count) # Initial state
    

    @input.each_line do |line|
      direction = line[0]
      distance = line[1..-1].to_i

      distance.times do
        case direction
        when 'L'
          position -= 1
          position = 99 if position < 0
        when 'R'
          position += 1
          position = 0 if position > 99
        end

        if count_each_step
          zero_count += 1 if position.zero? 
          update_data(position, distance, direction, zero_count)

        end
      end
      if !count_each_step
        zero_count += 1 if position.zero?
        update_data(position, distance, direction, zero_count)
      end
    end

    zero_count
  end

  def update_data(position, distance, direction, zero_count)
    @data ||= []
    @data << {position: position, distance: distance, direction: direction, zero_counts: zero_count}
  end
end