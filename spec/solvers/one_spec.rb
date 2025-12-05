# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::One do
  let(:input) { AdventOfCode::Loaders::Input.load(1, use_fixture: true) }
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_01.txt", { part_a: 3, part_b: 6 }
end
