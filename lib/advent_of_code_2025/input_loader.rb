
# Loads puzzle input files for Advent of Code 2025 solutions.
#
# This class provides a utility method to read input data from text files
# stored in the inputs directory. Each day's input is expected to be in a
# file named "day_XX.txt" where XX is the zero-padded day number.
#
# @example Loading input for day 1
#   AdventOfCode2025::InputLoader.load(1)
#   # => Contents of inputs/day_01.txt
#
# @example Loading input for day 25
#   AdventOfCode2025::InputLoader.load(25)
#   # => Contents of inputs/day_25.txt
class AdventOfCode2025::InputLoader
  def self.load(day)
    input_file = File.join(AdventOfCode2025::PROJECT_ROOT, "inputs", "day_%02d.txt" % day)
    unless File.exist?(input_file)
      raise Error, "Input file not found: #{input_file}"
    end
    File.read(input_file)
  end
end