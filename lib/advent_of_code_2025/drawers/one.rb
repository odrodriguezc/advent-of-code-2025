class AdventOfCode2025::Drawers::One < AdventOfCode2025::Drawers::Base
  def initialize(data)
    super(data)
    # Define the color palette using hex codes as instance variables
   # Base palette
    @background_color         = '#f6f4d2' # cream

    @outer_circle_color       = '#cbdfbd' # soft green border
    @inner_circle_color       = '#d4e09b' # richer green-yellow fill

    @needle_color             = '#f19c79' # coral accent
    @needle_highlight_color   = '#a44a3f' # deep brown when crossing zero

    # Text hierarchy
    @title_text_color         = '#a44a3f' # main titles & key numbers
    @secondary_text_color     = '#f19c79' # distance, time, secondary labels
    @muted_text_color         = '#cbdfbd' # very subtle labels if needed

    # Numbers on the dial
    @number_color             = '#a44a3f' # highlighted tick numbers
    @default_number_color     = '#f6f4d2' # “hidden” / inactive ticks
    @highlight_color          = '#f19c79' # when you want extra emphasis

    # Stats
    @zero_count_color         = @title_text_color  # reuse: keeps things consistent
    @distance_color           = @secondary_text_color
    @clock_color              = @secondary_text_color
    @finish_text_color        = '#a44a3f'          # or @secondary_text_color if you want it softer

  end

  def draw
    # Explicitly use Window to set properties
    Window.set(title: "Day 1 - Circular Cadran", width: 1600, height: 1600, background: @background_color)

    # Calculate dynamic dimensions based on the viewport
    center_x = percent_x(50) # Center of the window in x-axis
    center_y = percent_y(50) # Center of the window in y-axis
    circle_radius = percent_y(40) # Circle radius as 40% of the window height
    number_radius = circle_radius * 1.2 # Increase spacing between numbers
    needle_length = circle_radius * 0.9

    # Draw the cadran (circle) with a gradient effect
    outer_circle = Circle.new(
      x: center_x, y: center_y, radius: circle_radius,
      sectors: 100, color: @outer_circle_color, z: 0
    )
    inner_circle = Circle.new(
      x: center_x, y: center_y, radius: circle_radius - 10,
      sectors: 100, color: @inner_circle_color, z: 1
    )

    # Draw the numbers (0 to 99) around the circle, initially hidden
    number_texts = {}
    (0..99).each do |i|
      angle = i * (2 * Math::PI / 100) - Math::PI / 2
      x = center_x + Math.cos(angle) * number_radius
      y = center_y + Math.sin(angle) * number_radius
      number_texts[i] = Text.new(
        i.to_s, x: x - 15, y: y - 15,
        size: 28, color: @number_color, z: 1
      )
      number_texts[i].remove # Hide the number initially
    end

    # Draw the needle with a clock-like shape
    needle = Triangle.new(
      x1: center_x, y1: center_y,
      x2: center_x - 10, y2: center_y - needle_length,
      x3: center_x + 10, y3: center_y - needle_length,
      color: @needle_color, z: 2
    )

    # Add a label to display zero counts
    zero_count_label = Text.new(
      "Zero Counts: 0", x: center_x, y: center_y - circle_radius - percent_y(10), # Adjusted offset
      size: 50, color: @zero_count_color
    )

    # Add a label to display distance and direction
    distance_label = Text.new(
      "Distance: 0", x: center_x, y: center_y - circle_radius - percent_y(6), # Adjusted offset
      size: 50, color: @distance_color
    )

    # Add a clock in the bottom-left corner
    clock_label = Text.new(
      "Time: 00:00", x: percent_x(5), y: percent_y(95),
      size: 30, color: @clock_color
    )

    # Start the animation loop
    animate_needle(needle, zero_count_label, distance_label, clock_label, inner_circle, number_texts, center_x, center_y, needle_length)

    Window.show
  end

  private

  # Helper method to calculate x position as a percentage of the window width
  def percent_x(percent)
    Window.width * (percent / 100.0)
  end

  # Helper method to calculate y position as a percentage of the window height
  def percent_y(percent)
    Window.height * (percent / 100.0)
  end

  def animate_needle(needle, zero_count_label, distance_label, clock_label, circle, number_texts, center_x, center_y, needle_length)
    return if @data.nil? || @data.empty?

    # Initialize animation state
    @current_index = 0
    @last_update_time = Time.now
    @start_time = Time.now
    @previous_position = nil
    @current_position = @data.first[:position] # Start at the initial position
    @previous_distance = nil # Track the previous distance value

    # Use Ruby2D's Window.update loop for animation
    Window.update do
      # Update every 0.3 seconds
      if Time.now - @last_update_time >= 0.3
        entry = @data[@current_index]
        target_position = entry[:position]
        zero_counts = entry[:zero_counts]
        distance = entry[:distance]
        direction = entry[:direction] # Get the direction ('L' or 'R')

        # Determine the next position based on the direction
        if @current_position != target_position
          @current_position = if direction == 'L'
                                (@current_position - 1) % 100 # Move left (wrap around)
                              else
                                (@current_position + 1) % 100 # Move right (wrap around)
                              end
        else
          # If the target position is reached, check if the distance has changed
          if @previous_distance != distance
            Thread.new do
              needle.color = @needle_highlight_color # Change the needle color
              sleep(0.2)
              needle.color = @needle_color # Revert the needle color
            end
            @previous_distance = distance # Update the previous distance
          end

          # Move to the next data entry
          @current_index += 1
          @last_update_time = Time.now
          if @current_index >= @data.size
            Text.new(
              "Finish Process", x: percent_x(50) - 100, y: percent_y(90),
              size: 50, color: @finish_text_color
            )
            Window.update {} # Stop further updates
          end
          next
        end

        # Calculate the angle for the current position
        angle = @current_position * (2 * Math::PI / 100) - Math::PI / 2

        # Update the needle position
        needle.x2 = center_x + Math.cos(angle) * needle_length
        needle.y2 = center_y + Math.sin(angle) * needle_length

        # Update number visibility
        number_texts.each { |_, text| text.remove } # Hide all numbers
        number_texts[@current_position].add # Show the current number

        # Highlight the current position
        number_texts[@previous_position]&.color = @default_number_color # Reset the previous position's color
        number_texts[@current_position].color = @highlight_color # Highlight the current position
        @previous_position = @current_position

        # Update the zero count label
        zero_count_label.text = "Zero Counts: #{zero_counts}"

        # Update the distance label with direction
        distance_label.text = "Distance: #{distance} (#{direction})"

        # Indicate when position 0 is hit
        if @current_position == 0
          circle.color = 'green' # Change the circle color to green
          Thread.new do
            sleep(0.2) # Wait for 0.2 seconds
            circle.color = @inner_circle_color # Revert the color back to gray
          end
        end

        # Update the clock
        elapsed_time = Time.now - @start_time
        minutes = (elapsed_time / 60).to_i
        seconds = (elapsed_time % 60).to_i
        clock_label.text = format("Time: %02d:%02d", minutes, seconds)

        @last_update_time = Time.now
      end
    end
  end
end