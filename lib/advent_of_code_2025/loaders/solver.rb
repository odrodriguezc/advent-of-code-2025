# Loaders::Solver is responsible for dynamically loading solver classes for specific Advent of Code days.
#
# This class provides a factory method to instantiate day-specific solver classes based on a numeric
# day identifier. It maps numeric days (1-12) to their corresponding class names and handles errors
# for missing mappings or undefined classes.
#
# @example Loading a solver for day 1
#   input = "puzzle input data"
#   solver = AdventOfCode2025::Loaders::Solver.load(1, input)
#   # Returns an instance of AdventOfCode2025::Solvers::One
#
# @example Handling an unmapped day
#   AdventOfCode2025::Loaders::Solver.load(25, input)
#   # Raises Error: "No class mapping found for day 25."
#
# @example Handling a missing class
#   AdventOfCode2025::Loaders::Solver.load(1, input)
#   # Raises Error: "Day class One not found." (if class doesn't exist)
class AdventOfCode2025::Loaders::Solver
  DAY_CLASS_MAP = {
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
    10 => "Ten",
    11 => "Eleven",
    12 => "Twelve"
  }.freeze

  def self.load(day, input)
    day_class_name = DAY_CLASS_MAP[day]
    raise AdventOfCode2025::Error, "No class mapping found for day #{day}." unless day_class_name

    begin
      klass = AdventOfCode2025::Solvers.const_get(day_class_name)
      klass.new(input)
    rescue NameError
      raise AdventOfCode2025::Error, "Day class #{day_class_name} not found."
    end
  end
end
