# frozen_string_literal: true

module AdventOfCode
  module Solvers
    # Solver for Day Five of Advent of Code
    # solve_part_a: Counts how many ingredients fall within any of the given ranges
    # solve_part_b: Merges overlapping or contiguous ranges and counts the total coverage
    # parse_input: Parses the input into ranges and ingredients
    class Five < Base
      def initialize(data)
        super(data)
        parse_input
      end

      private

      def parse_input
        ranges_list, ingredients_list = @input.split("\n\n")
        @ranges_limits = ranges_list.lines.map { |l| l.chomp.split("-") }
        @ingredients = ingredients_list.lines.map { |line| line.chomp.to_i }
      end

      def solve_part_a
        @ingredients.count do |ingredient|
          @ranges_limits.any? { |range| (range[0].to_i..range[1].to_i).cover?(ingredient) }
        end
      end

      def solve_part_b
        ranges = @ranges_limits.map { |r| [r[0].to_i, r[1].to_i] }.uniq
        ranges.sort_by!(&:first)
        merged = [[ranges.first[0], ranges.first[1]]]

        ranges[1..].each do |start, finish|
          _last_start, last_finish = merged.last

          if start <= last_finish + 1 # +1 Because ranges are inclusive, goddamn it !
            merged.last[1] = [last_finish, finish].max
          else
            merged << [start, finish]
          end
        end
        merged.sum { |s, e| (e - s) + 1 } # +1 Because subtraction does not account for inclusive ranges
      end
    end
  end
end
