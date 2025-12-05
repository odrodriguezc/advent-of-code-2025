# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Four do
  let(:input) { AdventOfCode::Loaders::Input.load(4, use_fixture: true) }
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_04.txt", { part_a: 13, part_b: 43 }
end
