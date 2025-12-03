class AdventOfCode2025::Drawers::One < AdventOfCode2025::Drawers::Base
  def draw
    # Explicitly use Window to set properties
    Window.set(title: "Day 1 - Circular Cadran", width: 1400, height: 1400, background: 'white')

    # Calculate dynamic dimensions based on the viewport
    center_x = percent_x(50) # Center of the window in x-axis
    center_y = percent_y(50) # Center of the window in y-axis
    circle_radius = percent_y(35) # Circle radius as 35% of the window height
    number_radius = circle_radius * 1.05
    needle_length = circle_radius * 0.96

    # Draw the cadran (circle) with values from 0 to 99
    circle = Circle.new(
      x: center_x, y: center_y, radius: circle_radius,
      sectors: 100, color: 'gray', z: 0
    )

    # Draw the numbers (0 to 99) around the circle
    number_texts = {}
    (0..99).each do |i|
      angle = i * (2 * Math::PI / 100) - Math::PI / 2
      x = center_x + Math.cos(angle) * number_radius
      y = center_y + Math.sin(angle) * number_radius
      number_texts[i] = Text.new(
        i.to_s, x: x - 12, y: y - 12,
        size: 24, color: 'black'
      )
    end

    # Draw the needle
    needle = Line.new(
      x1: center_x, y1: center_y,
      x2: center_x, y2: center_y - needle_length,
      width: 6, color: 'red', z: 1
    )

    # Add a label to display zero counts
    zero_count_label = Text.new(
      "Zero Counts: 0", x: center_x, y: center_y - circle_radius - percent_y(14),
      size: 50, color: 'blue'
    )

    # Add a label to display distance
    distance_label = Text.new(
      "Distance: 0", x: center_x, y: center_y - circle_radius - percent_y(8),
      size: 50, color: 'green'
    )

    # Start the animation loop
    animate_needle(needle, zero_count_label, distance_label, circle, number_texts, center_x, center_y, needle_length)

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

  def animate_needle(needle, zero_count_label, distance_label, circle, number_texts, center_x, center_y, needle_length)
    return if @data.nil? || @data.empty?

    # Initialize animation state
    @current_index = 0
    @last_update_time = Time.now
    @previous_position = nil

    # Use Ruby2D's Window.update loop for animation
    Window.update do
      # Update every 1 second
      if Time.now - @last_update_time >= 0.3
        entry = @data[@current_index]
        position = entry[:position]
        zero_counts = entry[:zero_counts]
        distance = entry[:distance] # Get the distance from the data
        angle = position * (2 * Math::PI / 100) - Math::PI / 2

        # Update the needle position
        needle.x2 = center_x + Math.cos(angle) * needle_length
        needle.y2 = center_y + Math.sin(angle) * needle_length

        # Highlight the current position
        number_texts[@previous_position]&.color = 'black' # Reset the previous position's color
        number_texts[position].color = 'red' # Highlight the current position
        @previous_position = position

        # Update the zero count label
        zero_count_label.text = "Zero Counts: #{zero_counts}"

        # Update the distance label
        distance_label.text = "Distance: #{distance}"

        # Indicate when position 0 is hit
        if position == 0
          circle.color = 'green' # Change the circle color to green
          Thread.new do
            sleep(0.2) # Wait for 0.5 seconds
            circle.color = 'gray' # Revert the color back to gray
          end
        end

        # Move to the next data entry
        @current_index += 1
        @last_update_time = Time.now

        # Show "Finish Process" message when all data is processed
        if @current_index >= @data.size
          Text.new(
            "Finish Process", x: percent_x(50) - 100, y: percent_y(90),
            size: 50, color: 'red'
          )
          Window.update {} # Stop further updates
        end
      end
    end
  end
end