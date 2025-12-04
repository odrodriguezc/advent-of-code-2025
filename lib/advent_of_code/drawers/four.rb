# frozen_string_literal: true

module AdventOfCode
  module Drawers
    # AdventOfCode::Drawers::Four is responsible for visualizing the solution
    # for Day 4 of Advent of Code 2025.
    # It animates the movement of a marker through a grid representing levels and paper rolls.
    # The drawer updates the grid and marker position based on events generated during the solving process.
    class Four < AdventOfCode::Drawers::Base
      CELL_SIZE = 15
      FRAME_DURATION = 0.01 # seconds per snapshot
      STATUS_BAR_HEIGHT = 40
      BACKGROUND_COLOR = "#000000"
      STATUS_TEXT_COLOR = "#ffffff"
      PAPER_ROLL_COLOR = "#6495ed" # cornflowerblue
      EMPTY_COLOR = "#00ff00"
      MOVED_ROLL_COLOR = EMPTY_COLOR
      MARKER_COLOR = "#ffd700" # gold

      def draw
        initial_grid = @data[:initial_grid]
        events = @data[:events]
        return if initial_grid.nil? || events.nil? || events.empty?

        window_width = initial_grid.first.size * CELL_SIZE
        window_height = initial_grid.size * CELL_SIZE + STATUS_BAR_HEIGHT # leave room for the status bar

        Window.set(title: "Advent of Code 2025 - Day 4", width: window_width, height: window_height,
                   background: BACKGROUND_COLOR)

        @grid = deep_clone(initial_grid)
        @cells = draw_grid(@grid)
        @marker = draw_marker(0, 0)
        @status_text = build_status(level: 0, row: 0, col: 0, rolls_moved: 0, frame_index: 0)

        @frame_index = 0
        @last_update_at = Time.now
        @finished = false

        Window.update do
          next unless Time.now - @last_update_at >= FRAME_DURATION

          if @frame_index >= events.size
            unless @finished
              last_event = events.last
              @status_text.text = "Finished | Level #{last_event[:level]} | Position (#{last_event[:row]}, #{last_event[:col]}) | Rolls moved: #{last_event[:rolls_moved]} | Frame #{@frame_index}"
              @finished = true
            end
          else
            event = events[@frame_index]

            # Update grid only on new frames to avoid flickering
            update_grid(event[:grid])
            @status_text.text = build_status(event.merge(frame_index: @frame_index))

            @frame_index += 1
            @finished = false
          end

          @last_update_at = Time.now
        end
      end

      private

      def draw_grid(grid)
        grid.map.with_index do |row, row_index|
          row.chars.map.with_index do |cell, col_index|
            Rectangle.new(
              x: col_index * CELL_SIZE, y: row_index * CELL_SIZE,
              width: CELL_SIZE - 1, height: CELL_SIZE - 1,
              color: cell_color(cell),
              z: 0
            )
          end
        end
      end

      def update_grid(grid)
        grid.each_with_index do |row, row_index|
          row.chars.each_with_index do |cell, col_index|
            @cells[row_index][col_index].color = cell_color(cell)
          end
        end
      end

      def draw_marker(row, col)
        Rectangle.new(
          x: col * CELL_SIZE, y: row * CELL_SIZE,
          width: CELL_SIZE - 1, height: CELL_SIZE - 1,
          color: MARKER_COLOR,
          z: 1
        )
      end

      def build_status(level:, row:, col:, rolls_moved:, frame_index:)
        "Level #{level} | Position (#{row}, #{col}) | Rolls moved: #{rolls_moved} | Frame #{frame_index}"
      end

      def update_marker(row, col)
        @marker.x = col * CELL_SIZE
        @marker.y = row * CELL_SIZE
      end

      def cell_color(cell)
        case cell
        when "#"
          PAPER_ROLL_COLOR
        when "x"
          MARKER_COLOR
        when "."
          EMPTY_COLOR
        else
          "#222222" # Unknown cell types appear as dark gray
        end
      end

      def deep_clone(grid)
        grid.map(&:dup)
      end

      def build_statistics(grid, row, col)
        total_rolls = grid.sum { |line| line.count("#") }
        adjacent_rolls = count_adjacent_rolls(grid, row, col)
        "Total Rolls: #{total_rolls} | Adjacent Rolls: #{adjacent_rolls}"
      end

      def count_adjacent_rolls(grid, row, col)
        adjacent_positions = [
          [row - 1, col],
          [row + 1, col],
          [row, col - 1],
          [row, col + 1]
        ]

        adjacent_positions.count do |r, c|
          next false if r.negative? || c.negative? || r >= grid.size || c >= grid.first.size

          grid[r][c] == "#"
        end
      end
    end
  end
end
