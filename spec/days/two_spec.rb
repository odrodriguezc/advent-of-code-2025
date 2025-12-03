require "spec_helper"

RSpec.describe AdventOfCode2025::Days::Two do
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_02.txt", { part_1: 1_227_775_554, part_2: 4_174_379_265 }
end
