# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Three do
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_03.txt", { part_1: 357, part_2: 3_121_910_778_619 }
end
