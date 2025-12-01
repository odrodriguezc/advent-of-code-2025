require 'spec_helper'

RSpec.describe AdventOfCode2025::Days::One do 

  def load_input
    filepath = File.join(AdventOfCode2025::PROJECT_ROOT, 'spec/support/fixtures/inputs', 'day_01.txt')
    File.read(filepath)
  end
  describe '#solve_part_1' do
    it 'solves part 1 correctly' do
      input = load_input
      day = AdventOfCode2025::Days::One.new(input)
      
      expect(day.solve(part: 1)).to eq(3)
    end
  end

  describe '#solve_part_2' do
    it 'solves part 2 correctly' do
      input = load_input
      day = AdventOfCode2025::Days::One.new(input)
      
      expect(day.solve(part: 2)).to eq(6)
    end
  end
end