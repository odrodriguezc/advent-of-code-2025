# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Four do
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_04.txt", { part_1: 13, part_2: 43 }
end
