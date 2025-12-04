# frozen_string_literal: true

module AdventOfCode
  module Solvers
    # The Solvers module contains solution classes for Advent of Code puzzles.
    #
    # @example
    #   # To use a solver, instantiate the corresponding class and call its methods:
    #   solver = AdventOfCode::Solvers::Three.new(input)
    #   result1 = solver.send(:solve_part_a)
    #   result2 = solver.send(:solve_part_b)
    #
    # @see AdventOfCode::Solvers::Three
    #
    # @note This module is intended to group all solver classes for organizational purposes.
    class Three < AdventOfCode::Solvers::Base
      Batery = Struct.new("Batery", :pos, :val)

      private

      def solve_part_a
        joltages = []
        @input.each_line do |line|
          power_bank_number_values = line.chomp.chars.map(&:to_i)
          max_value = power_bank_number_values[0..-2].max

          index_of_max_value = power_bank_number_values.index(max_value)
          second_max_value = power_bank_number_values[index_of_max_value + 1..].max

          joltages << [max_value.to_s, second_max_value.to_s].join.to_i
        end
        joltages.sum
      end

      def solve_part_b
        joltages = []
        total_jolts = 12
        fetch_lines.each do |line|
          line_max_pos = line.max_by(&:pos).pos
          line_jols = []

          left_min_pos_pointer = 0
          (1..total_jolts).to_a.reverse.each do |right_pointer|
            sub_line = line.select do |batery|
              batery.pos > left_min_pos_pointer && batery.pos + (right_pointer - 1) <= line_max_pos
            end
            max_jol = sub_line.max_by(&:val)

            left_min_pos_pointer = max_jol.pos

            line_jols << max_jol
          end

          l_joltage = line_jols.map(&:val).join.to_i
          joltages << l_joltage
        end
        joltages.sum
      end

      def fetch_lines
        @input.each_line.map do |l|
          l.chomp.chars.map(&:to_i).map.with_index do |v, i|
            Batery.new(i + 1, v)
          end
        end
      end
    end
  end
end
