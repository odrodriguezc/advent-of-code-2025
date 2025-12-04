# frozen_string_literal: true

module AdventOfCode
  module Solvers
    # The Solvers module contains solution classes for Advent of Code puzzles.
    # @example
    #   # To use a solver, instantiate the corresponding class and call its methods:
    #   solver = AdventOfCode::Solvers::Two.new(input)
    #   result1 = solver.send(:solve_part_a)
    #   result2 = solver.send(:solve_part_b)
    # @see AdventOfCode::Solvers::Two
    # @note This module is intended to group all solver classes for organizational purposes.
    class Two < AdventOfCode::Solvers::Base
      private

      def solve_part_a
        condition = ->(num_as_str) { symmetric_halves?(num_as_str) }
        find_repeated_numbers(condition).sum
      end

      def solve_part_b
        pattern = /\A(\d+)\1+\z/
        condition = ->(num_as_str) { num_as_str.match?(pattern) }
        find_repeated_numbers(condition).sum
      end

      def find_repeated_numbers(condition)
        ranges_collection = @input.split(",")
        repeated_numbers = []

        ranges_collection.each do |range|
          start_num, end_num = range.split("-").map(&:to_i)
          (start_num..end_num).each do |num|
            num_as_str = num.to_s
            repeated_numbers << num if condition.call(num_as_str)
          end
        end

        repeated_numbers
      end

      def symmetric_halves?(num_as_str)
        size = num_as_str.size
        return false if size.odd? # Odd numbers can't have symmetric halves

        left_half = num_as_str[0..size / 2 - 1]
        right_half = num_as_str[(size / 2)..]
        left_half == right_half
      end
    end
  end
end
