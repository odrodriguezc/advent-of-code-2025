# frozen_string_literal: true

require_relative "advent_of_code/version"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module AdventOfCode
  PROJECT_ROOT = File.expand_path("..", __dir__)
  class Error < StandardError; end
  # Your code goes here...
end

loader.eager_load
