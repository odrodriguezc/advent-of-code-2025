
# Runner class for executing Advent of Code 2025 solutions.
#
# This class coordinates the loading of input data and solver classes,
# then executes the appropriate solution for a given day and part.
#
# @example Running a solution
#   runner = AdventOfCode2025::Runner.new(day: 1, part: 1)
#   result = runner.run
#
# @attr_reader day [Integer] the day number of the puzzle (1-25)
# @attr_reader part [Integer] the part number of the puzzle (1-2)
class AdventOfCode2025::Runner
  def initialize(day:, part:)
    @day = day
    @part = part
  end

  def run
    input = AdventOfCode2025::InputLoader.load(@day)
    solver = AdventOfCode2025::SolverLoader.load(@day, input)
    solver.solve(part: @part)
  end
end