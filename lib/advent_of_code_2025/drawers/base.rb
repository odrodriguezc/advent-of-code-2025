require "ruby2d"

class AdventOfCode2025::Drawers::Base
  def initialize(solver)
    @data = solver.data
  end

  def draw
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end
