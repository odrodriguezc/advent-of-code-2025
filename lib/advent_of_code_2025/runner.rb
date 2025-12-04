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
  attr_reader :day, :part, :result, :drawer

  def initialize(day:, part:, use_fixture: false, visualize: false)
    @day = day
    @part = part
    @use_fixture = use_fixture # Store the flag to use fixture inputs
    @visualize = visualize
  end

  def run
    input = AdventOfCode2025::Loaders::Input.load(@day, use_fixture: @use_fixture) # Pass the flag to the loader
    solver = AdventOfCode2025::Loaders::Solver.load(@day, input)
    @result = solver.solve(part: @part)
    @drawer = AdventOfCode2025::Loaders::Drawer.load(@day, solver) if @visualize
  end
end
