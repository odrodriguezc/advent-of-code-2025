# frozen_string_literal: true

module AdventOfCode
  module Loaders
    # Loads puzzle input files for Advent of Code 2025 solutions.
    #
    # This class provides a utility method to read input data from text files
    # stored in the inputs directory. Each day's input is expected to be in a
    # file named "day_XX.txt" where XX is the zero-padded day number.
    #
    # @example Loading input for day 1
    #   AdventOfCode::Loaders::Input.load(1)
    #   # => Contents of inputs/day_01.txt
    #
    # @example Loading input for day 25
    #   AdventOfCode::Loaders::Input.load(25)
    #   # => Contents of inputs/day_25.txt
    class Input
      def self.load(day, use_fixture: false)
        inputs_dir = if use_fixture
                       File.join(AdventOfCode::PROJECT_ROOT, "spec/support/fixtures/inputs")
                     else
                       File.join(AdventOfCode::PROJECT_ROOT, "inputs")
                     end

        input_file = File.join(inputs_dir, format("day_%02d.txt", day))
        raise AdventOfCode::Error, "Input file not found: #{input_file}" unless File.exist?(input_file)

        File.read(input_file)
      end
    end
  end
end
