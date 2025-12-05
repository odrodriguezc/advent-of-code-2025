# frozen_string_literal: true

require "spec_helper"

RSpec.describe AdventOfCode::Solvers::Three do
  let(:input) { AdventOfCode::Loaders::Input.load(3, use_fixture: true) }
  it_behaves_like "a base solver inheritance"
  it_behaves_like "a day solver", "day_03.txt", { part_a: 357, part_b: 3_121_910_778_619 }
end
