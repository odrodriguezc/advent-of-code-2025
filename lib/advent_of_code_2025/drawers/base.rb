class AdventOfCode2025::Drawers::Base
  require 'ruby2d'

  def initialize(solver)
    @data = solver.data
  end

  def draw
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end