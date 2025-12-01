# AdventOfCode2025

AdventOfCode2025 is a Ruby gem designed to solve the challenges of [Advent of Code 2025](https://adventofcode.com/2025) in an organized and structured way. This project follows Ruby gem conventions and uses object-oriented programming principles to provide a clean and modular solution for each day's challenges.

## Features

- **Daily Challenges**: Each day has its own class to encapsulate the logic for solving the two parts of the challenge.
- **Input Management**: Automatically loads input files for each day.
- **CLI Launcher**: Run solutions for specific days and parts directly from the command line.
- **Gem Structure**: Organized as a Ruby gem for maintainability and extensibility.
- **Testing**: Includes RSpec tests for each day's solutions.

## Installation

To use this gem locally, clone the repository and install dependencies:

```bash
git clone https://github.com/[USERNAME]/advent_of_code_2025.git
cd advent_of_code_2025
bundle install
```

## Usage

### Running Solutions

To run the solution for a specific day and part, use the `bin/run` script:

```bash
bin/run DAY PART
```

For example, to run Day 1, Part 2:

```bash
bin/run 1 2
```

### Input Files

Input files for each day should be placed in the `inputs/` directory and named as `day_XX.txt` (e.g., `day_01.txt` for Day 1). Example inputs are provided in the `spec/support/fixtures/inputs/` directory for testing purposes.

### Example

Given the input file `inputs/day_01.txt`, the following command will execute the solution for Day 1, Part 1:

```bash
bin/run 1 1
```

The output will display the solution for the specified day and part.

## Development

This project is structured as a Ruby gem. To contribute or experiment with the code:

1. Clone the repository.
2. Run `bin/setup` to install dependencies.
3. Use `bin/console` for an interactive Ruby session.
4. Run tests with `rake spec`.

To install the gem locally:

```bash
bundle exec rake install
```

## Project Structure

- `bin/`: Contains executable scripts, including the CLI launcher (`run`).
- `inputs/`: Stores input files for each day's challenge.
- `lib/`: Contains the main codebase, including:
  - `advent_of_code_2025/runner.rb`: Handles the logic for running solutions.
  - `advent_of_code_2025/days/`: Contains classes for each day's solutions.
- `spec/`: Contains RSpec tests for the project.
- `spec/support/fixtures/inputs/`: Example input files for testing.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/[USERNAME]/advent_of_code_2025](https://github.com/[USERNAME]/advent_of_code_2025).

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Acknowledgments

Thanks to [Advent of Code](https://adventofcode.com/) for providing these fun and challenging problems every year!
