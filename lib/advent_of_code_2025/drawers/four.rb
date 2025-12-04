class AdventOfCode2025::Drawers::Four < AdventOfCode2025::Drawers::Base
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
        next
      end

      event = events[@frame_index]
      apply_event(event)
      update_marker(event[:row], event[:col])
      update_status(event, @frame_index + 1)

      @frame_index += 1
      @last_update_at = Time.now
    end

    Window.show
  end

  private

  def draw_grid(grid)
    grid.map.with_index do |row, r|
      row.map.with_index do |cell, c|
        Square.new(
          x: c * CELL_SIZE,
          y: r * CELL_SIZE + STATUS_BAR_HEIGHT, # offset to leave room for the status text
          size: CELL_SIZE,
          color: color_for(cell)
        )
      end
    end
  end

  def apply_event(event)
    row = event[:row]
    col = event[:col]
    @grid[row][col] = "X"
    @cells[row][col].color = color_for("X")
  end

  def build_status(level:, row:, col:, rolls_moved:, frame_index:)
    Text.new(
      "Level #{level} | Position (#{row}, #{col}) | Rolls moved: #{rolls_moved} | Frame #{frame_index}",
      x: 10,
      y: 10,
      size: 18,
      color: STATUS_TEXT_COLOR
    )
  end

  def update_status(event, frame_index)
    @status_text.text = "Level #{event[:level]} | Position (#{event[:row]}, #{event[:col]}) | Rolls moved: #{event[:rolls_moved]} | Frame #{frame_index}"
  end

  def color_for(value)
    case value
    when "@"
      PAPER_ROLL_COLOR
    when "X"
      MOVED_ROLL_COLOR
    else
      EMPTY_COLOR
    end
  end

  def draw_marker(row, col)
    marker_size = (CELL_SIZE * 0.6).to_i
    padding = (CELL_SIZE - marker_size) / 2

    Square.new(
      x: col * CELL_SIZE + padding,
      y: row * CELL_SIZE + STATUS_BAR_HEIGHT + padding,
      size: marker_size,
      color: MARKER_COLOR
    )
  end

  def update_marker(row, col)
    marker_size = (CELL_SIZE * 0.6).to_i
    padding = (CELL_SIZE - marker_size) / 2
    @marker.x = col * CELL_SIZE + padding
    @marker.y = row * CELL_SIZE + STATUS_BAR_HEIGHT + padding
  end

  def deep_clone(grid)
    grid.map(&:dup)
  end
end
