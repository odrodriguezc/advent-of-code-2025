# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::One do
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_01.txt", { part_1: 3, part_2: 6 }
end
