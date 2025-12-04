# frozen_string_literal: true

module AdventOfCode
  module Loaders
    # AdventOfCode::Loaders::Drawer is responsible for loading the appropriate drawer class
    # for a given Advent of Code day, using a mapping from day numbers to class names.
    #
    # DAY_CLASS_MAP:
    #   Maps day numbers (1-12) to their corresponding class names as strings.
    #
    # .load(day, data):
    #   Loads and instantiates the drawer class for the specified day.
    #   - day: Integer representing the Advent of Code day.
    #   - data: Data to be passed to the drawer class initializer.
    #   Raises AdventOfCode::Error if the day is not mapped or the class is not found.
    class Drawer
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

      def self.load(day, solver)
        day_class_name = DAY_CLASS_MAP[day]
        raise AdventOfCode::Error, "No class mapping found for day #{day}." unless day_class_name

        begin
          klass = AdventOfCode::Drawers.const_get(day_class_name)
          klass.new(solver)
        rescue NameError
          raise AdventOfCode::Error, "Day class #{day_class_name} not found."
        end
      end
    end
  end
end
