# frozen_string_literal: true

require "ruby2d"

module AdventOfCode
  module Drawers
    # AdventOfCode::Drawers::Base serves as the abstract base class for all drawer implementations.
    # It provides a common interface and shared functionality for visualizing
    # solutions to Advent of Code 2025 puzzles.
    # Subclasses must implement the `draw` method to define specific drawing behavior.
    # @example Creating a custom drawer
    #   class CustomDrawer < AdventOfCode::Drawers::Base
    #     def draw
    #       # Custom drawing logic here
    #     end
    #   end
    #   drawer = CustomDrawer.new(solver)
    #   drawer.draw # invokes the custom drawing logic
    #   @param solver [AdventOfCode::Solvers::Base] The solver instance containing puzzle data.
    #   @raise [NotImplementedError] if the `draw` method is not implemented in a subclass.
    #   data [Hash] The data extracted from the solver for drawing.
    class Base
      def initialize(solver)
        @data = solver.data
      end

      def draw
        raise NotImplementedError, "This #{self.class} cannot respond to:"
      end
    end
  end
end
