# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Two do
  let(:input) { AdventOfCode::Loaders::Input.load(2, use_fixture: true) }
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_02.txt", { part_a: 1_227_775_554, part_b: 4_174_379_265 }
end
