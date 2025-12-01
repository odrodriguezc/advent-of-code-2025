# frozen_string_literal: true

require_relative "advent_of_code_2025/version"
require 'zeitwerk'

module AdventOfCode2025
  PROJECT_ROOT = File.expand_path('..', __dir__)
  class Error < StandardError; end
  # Your code goes here...
  loader = Zeitwerk::Loader.for_gem
  loader.setup # ready!
end
