# frozen_string_literal: true

RSpec.describe AdventOfCode::Runner do
  let(:day) { 1 }
  let(:part) { 2 }
  let(:input) { double("input") }
  let(:solver) { double("solver") }
  let(:drawer) { double("drawer") }
  let(:solution_result) { "solution" }
  let(:use_fixture) { false }
  let(:visualize) { false }

  before do
    allow(AdventOfCode::Loaders::Input).to receive(:load).with(day, use_fixture: use_fixture).and_return(input)
    allow(AdventOfCode::Loaders::Solver).to receive(:load).with(day, input).and_return(solver)
    allow(solver).to receive(:solve).with(part: part).and_return(solution_result)
    allow(AdventOfCode::Loaders::Drawer).to receive(:load).with(day, solver).and_return(drawer)
  end

  describe "#initialize" do
    it "sets day, part, and use_fixture attributes" do
      runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
      expect(runner.day).to eq(day)
      expect(runner.part).to eq(part)
    end
  end

  describe "#run" do
    it "loads input with use_fixture, solver, and solves" do
      runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
      runner.run

      expect(AdventOfCode::Loaders::Input).to have_received(:load).with(day, use_fixture: use_fixture)
      expect(AdventOfCode::Loaders::Solver).to have_received(:load).with(day, input)
      expect(solver).to have_received(:solve).with(part: part)
    end

    it "sets result attribute" do
      runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
      runner.run

      expect(runner.result).to eq(solution_result)
    end

    context "when visualize is true" do
      let(:visualize) { true }

      it "loads drawer" do
        runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
        runner.run

        expect(AdventOfCode::Loaders::Drawer).to have_received(:load).with(day, solver)
        expect(runner.drawer).to eq(drawer)
      end
    end

    context "when visualize is false" do
      it "does not load drawer" do
        runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
        runner.run

        expect(AdventOfCode::Loaders::Drawer).not_to have_received(:load)
        expect(runner.drawer).to be_nil
      end
    end
  end

  context "when use_fixture is true" do
    let(:use_fixture) { true }

    it "loads input from fixture files" do
      runner = described_class.new(day: day, part: part, use_fixture: use_fixture, visualize: visualize)
      runner.run

      expect(AdventOfCode::Loaders::Input).to have_received(:load).with(day, use_fixture: use_fixture)
    end
  end
end
