# frozen_string_literal: true

RSpec.describe AdventOfCode::Loaders::Solver do
  let(:input) { "test input" }

  describe ".load" do
    context "when day is mapped and class exists" do
      before do
        # Stub the class for this test
        stub_const("AdventOfCode::Solvers::One", Class.new do
          def initialize(input) = @input = input
        end)
      end

      it "returns an instance of the correct class" do
        solver = described_class.load(1, input)
        expect(solver).to be_a(AdventOfCode::Solvers::One)
      end
    end

    context "when day is not mapped" do
      it "raises an error for unmapped day" do
        expect do
          described_class.load(25, input)
        end.to raise_error(AdventOfCode::Error, "No class mapping found for day 25.")
      end
    end

    context "when class does not exist for mapped day" do
      before do
        # Ensure the constant is not defined for this test
        AdventOfCode::Solvers.send(:remove_const, :One) if AdventOfCode::Solvers.const_defined?(:One)
      end

      it "raises an error for missing class" do
        expect do
          described_class.load(1, input)
        end.to raise_error(AdventOfCode::Error, "Day class One not found.")
      end
    end
  end
end
