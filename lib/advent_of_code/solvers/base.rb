# frozen_string_literal: true

module AdventOfCode
  module Solvers
    # Base class for Advent of Code 2025 day solutions.
    #
    # This class provides a common interface for all daily puzzle solutions.
    # Each day's solution should inherit from this class and implement the
    # solve_part_a and solve_part_b methods.
    #
    # @example Creating a day solution
    #   class AdventOfCode::Solvers::Day01 < AdventOfCode::Solvers::Base
    #     private
    #
    #     def solve_part_a
    #       # Implementation for part 1
    #     end
    #
    #     def solve_part_b
    #       # Implementation for part 2
    #     end
    #   end
    #
    # @example Using a day solution
    #   input = File.read("input.txt")
    #   solution = AdventOfCode::Solvers::Day01.new(input)
    #   result_part_1 = solution.solve(part: 1)
    #   result_part_2 = solution.solve(part: 2)
    class Base
      attr_reader :data

      def initialize(input)
        @input = input
        @data = nil
      end

      def solve(part: "a")
        case part.to_s.downcase
        when "a", "1"
          solve_part_a
        when "b", "2"
          solve_part_b
        else
          raise ArgumentError, "Unknown part: #{part.inspect}"
        end
      end

      private

      def solve_part_a
        raise NotImplementedError, "This #{self.class} cannot respond to:"
      end

      def solve_part_b
        raise NotImplementedError, "This #{self.class} cannot respond to:"
      end
    end
  end
end
