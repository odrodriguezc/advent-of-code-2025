# frozen_string_literal: true

RSpec.shared_examples "a day solver" do |input_file, expected_results|
  def load_input(file)
    filepath = File.join(AdventOfCode::PROJECT_ROOT, "spec/support/fixtures/inputs", file)
    File.read(filepath)
  end

  describe "#solve_part_a" do
    it "solves part 1 correctly" do
      input = load_input(input_file)
      day = described_class.new(input)

      expect(day.solve(part: 1)).to eq(expected_results[:part_a])
    end
  end

  describe "#solve_part_b" do
    it "solves part 2 correctly" do
      input = load_input(input_file)
      day = described_class.new(input)

      expect(day.solve(part: 2)).to eq(expected_results[:part_b])
    end
  end
end
