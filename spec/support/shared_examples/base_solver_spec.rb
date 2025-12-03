require "spec_helper"

RSpec.shared_examples "a base solver inheritance" do
  describe "inheritance" do
    it "inherits from Base solver" do
      expect(described_class < AdventOfCode2025::Solvers::Base).to be true
    end
  end

  describe "initialization" do
    it "can be initialized with input" do
      input = "sample input"
      day = described_class.new(input)
      expect(day).to be_a(described_class)
    end
  end

  describe "#solve" do
    it "responds to solve method" do
      input = "sample input"
      day = described_class.new(input)
      expect(day).to respond_to(:solve)
    end
  end
end
