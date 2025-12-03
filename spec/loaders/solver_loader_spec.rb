RSpec.describe AdventOfCode2025::Loaders::Solver do
  let(:input) { "test input" }

  describe '.load' do
    context 'when day is mapped and class exists' do
      before do
        # Stub the class for this test
        stub_const("AdventOfCode2025::Solvers::One", Class.new do
          def initialize(input); @input = input; end
        end)
      end

      it 'returns an instance of the correct class' do
        solver = described_class.load(1, input)
        expect(solver).to be_a(AdventOfCode2025::Solvers::One)
      end
    end

    context 'when day is not mapped' do
      it 'raises an error for unmapped day' do
        expect {
          described_class.load(25, input)
        }.to raise_error(AdventOfCode2025::Error, "No class mapping found for day 25.")
      end
    end

    context 'when class does not exist for mapped day' do
      before do
        # Ensure the constant is not defined for this test
        if AdventOfCode2025::Solvers.const_defined?(:One)
          AdventOfCode2025::Solvers.send(:remove_const, :One)
        end
      end

      it 'raises an error for missing class' do
        expect {
          described_class.load(1, input)
        }.to raise_error(AdventOfCode2025::Error, "Day class One not found.")
      end
    end
  end
end