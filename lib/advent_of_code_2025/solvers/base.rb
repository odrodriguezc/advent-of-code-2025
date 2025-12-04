# Base class for Advent of Code 2025 day solutions.
#
# This class provides a common interface for all daily puzzle solutions.
# Each day's solution should inherit from this class and implement the
# solve_part_1 and solve_part_2 methods.
#
# @example Creating a day solution
#   class AdventOfCode2025::Solvers::Day01 < AdventOfCode2025::Solvers::Base
#     private
#
#     def solve_part_1
#       # Implementation for part 1
#     end
#
#     def solve_part_2
#       # Implementation for part 2
#     end
#   end
#
# @example Using a day solution
#   input = File.read("input.txt")
#   solution = AdventOfCode2025::Solvers::Day01.new(input)
#   result_part_1 = solution.solve(part: 1)
#   result_part_2 = solution.solve(part: 2)
class AdventOfCode2025::Solvers::Base
  attr_reader :data

  def initialize(input)
    @input = input
    @data = nil
  end

  def solve(part: 1)
    part == 1 ? solve_part_1 : solve_part_2
  end

  private

  def solve_part_1
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def solve_part_2
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end
