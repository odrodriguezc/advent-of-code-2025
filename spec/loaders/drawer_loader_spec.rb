# frozen_string_literal: true

RSpec.describe AdventOfCode::Loaders::Drawer do
  let(:data) { "test input" }

  describe ".load" do
    context "when day is mapped and class exists" do
      before do
        # Stub the class for this test
        stub_const("AdventOfCode::Drawers::One", Class.new do
          def initialize(data) = @data = data
        end)
      end

      it "returns an instance of the correct class" do
        drawer = described_class.load(1, data)
        expect(drawer).to be_a(AdventOfCode::Drawers::One)
      end
    end

    context "when day is not mapped" do
      it "raises an error for unmapped day" do
        expect do
          described_class.load(99, data)
        end.to raise_error(AdventOfCode::Error, "No class mapping found for day 99.")
      end
    end

    context "when class does not exist for mapped day" do
      before do
        # Ensure the constant is not defined for this test
        AdventOfCode::Drawers.send(:remove_const, :One) if AdventOfCode::Drawers.const_defined?(:One)
      end

      it "raises an error for missing class" do
        expect do
          described_class.load(1, data)
        end.to raise_error(AdventOfCode::Error, "Day class One not found.")
      end
    end
  end
end
