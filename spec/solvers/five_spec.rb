# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Five do
  let(:input) { AdventOfCode::Loaders::Input.load(5, use_fixture: true) }
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_05.txt", { part_a: 3, part_b: 14 }
end
