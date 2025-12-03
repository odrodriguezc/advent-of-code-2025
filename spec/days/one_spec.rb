require "spec_helper"

RSpec.describe AdventOfCode2025::Days::One do
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_01.txt", { part_1: 3, part_2: 6 }
end
