require 'spec_helper'
require 'fileutils'

RSpec.describe AdventOfCode2025::Loaders::Input do
  describe '.load' do
    let(:inputs_dir) { File.join(AdventOfCode2025::PROJECT_ROOT, "inputs") }
    let(:day) { 3 }
    let(:input_file) { File.join(inputs_dir, "day_03.txt") }

    before do
      FileUtils.mkdir_p(inputs_dir)
    end

    after do
      FileUtils.rm_rf(inputs_dir)
    end

    context 'when the input file exists' do
      it 'returns the contents of the input file' do
        File.write(input_file, "test input")
        expect(described_class.load(day)).to eq("test input")
      end
    end

    context 'when the input file does not exist' do
      it 'raises an Error with a descriptive message' do
        expect { described_class.load(day) }
          .to raise_error(AdventOfCode2025::Error, /Input file not found/)
      end
    end
  end
end