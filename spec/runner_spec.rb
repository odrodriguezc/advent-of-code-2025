RSpec.describe AdventOfCode2025::Runner do
  let(:day) { 1 }
  let(:part) { 2 }
  let(:input) { double('input') }
  let(:solver) { double('solver') }
  let(:drawer) { double('drawer') }
  let(:solution_result) { 'solution' }

  before do
    allow(AdventOfCode2025::Loaders::Input).to receive(:load).with(day).and_return(input)
    allow(AdventOfCode2025::Loaders::Solver).to receive(:load).with(day, input).and_return(solver)
    allow(solver).to receive(:solve).with(part: part).and_return(solution_result)
    allow(AdventOfCode2025::Loaders::Drawer).to receive(:load).with(day, solver).and_return(drawer)
  end

  describe '#initialize' do
    it 'sets day and part attributes' do
      runner = described_class.new(day: day, part: part)
      expect(runner.day).to eq(day)
      expect(runner.part).to eq(part)
    end
  end

  describe '#run' do
    it 'loads input, solver, solves, and loads drawer' do
      runner = described_class.new(day: day, part: part)
      runner.run

      expect(AdventOfCode2025::Loaders::Input).to have_received(:load).with(day)
      expect(AdventOfCode2025::Loaders::Solver).to have_received(:load).with(day, input)
      expect(solver).to have_received(:solve).with(part: part)
      expect(AdventOfCode2025::Loaders::Drawer).to have_received(:load).with(day, solver)
    end

    it 'sets result and drawer attributes' do
      runner = described_class.new(day: day, part: part)
      runner.run

      expect(runner.result).to eq(solution_result)
      expect(runner.drawer).to eq(drawer)
    end
  end
end