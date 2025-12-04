# frozen_string_literal: true

module AdventOfCode
  module Solvers
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
    class One < AdventOfCode::Solvers::Base
      START_POSITION = 50

      private

      def solve_part_a
        process_input(count_each_step: false)
      end

      def solve_part_b
        process_input(count_each_step: true)
      end

      def process_input(count_each_step:)
        position = START_POSITION
        zero_count = 0
        update_data(position, 0, nil, zero_count) # Initial state

        @input.each_line do |line|
          direction = line[0]
          distance = line[1..]

          distance.to_i.times do
            position = get_next_position(position, direction)

            next unless count_each_step

            zero_count += 1 if position.zero?
            update_data(position, distance, direction, zero_count)
          end
          unless count_each_step
            zero_count += 1 if position.zero?
            update_data(position, distance, direction, zero_count)
          end
        end

        zero_count
      end

      def get_next_position(current_position, direction)
        case direction
        when "L"
          current_position -= 1
          current_position = 99 if current_position.negative?
        when "R"
          current_position += 1
          current_position = 0 if current_position > 99
        end
        current_position
      end

      def update_data(position, distance, direction, zero_count)
        @data ||= []
        @data << { position: position, distance: distance, direction: direction, zero_counts: zero_count }
      end
    end
  end
end
