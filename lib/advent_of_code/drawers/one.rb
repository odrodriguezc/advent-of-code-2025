# frozen_string_literal: true

module AdventOfCode
  module Drawers
    # AdventOfCode::Drawers::One is responsible for visualizing the solution
    # for Day 1 of Advent of Code 2025.
    # It creates a circular cadran with a needle that animates based on input data.
    class One < AdventOfCode::Drawers::Base
      def initialize(data)
        super(data)
        initialize_colors
        @animation_speed = 0.01
      end

      def draw
        setup_window
        dimensions = calculate_dimensions
        components = draw_components(dimensions)
        start_animation(components, dimensions)
        Window.show
      end

      private

      def initialize_colors
        @background_color = "#f6f4d2" # cream

        @outer_circle_color       = "#cbdfbd" # soft green border
        @inner_circle_color       = "#d4e09b" # richer green-yellow fill

        @needle_color             = "#f19c79" # coral accent
        @needle_highlight_color   = "#a44a3f" # deep brown when crossing zero

        # Text hierarchy
        @title_text_color         = "#a44a3f" # main titles & key numbers
        @secondary_text_color     = "#f19c79" # distance, time, secondary labels
        @muted_text_color         = "#cbdfbd" # very subtle labels if needed

        # Numbers on the dial
        @number_color             = "#a44a3f" # highlighted tick numbers
        @default_number_color     = "#f6f4d2" # “hidden” / inactive ticks
        @highlight_color          = "#f19c79" # when you want extra emphasis

        # Stats
        @zero_count_color         = @title_text_color  # reuse: keeps things consistent
        @distance_color           = @secondary_text_color
        @clock_color              = @secondary_text_color
        @finish_text_color        = "#a44a3f"          # or @secondary_text_color if you want it softer
      end

      def setup_window
        Window.set(
          title: "Day 1 - Circular Cadran",
          width: 1600,
          height: 1600,
          background: @background_color
        )
      end

      def calculate_dimensions
        {
          center_x: percent_x(50),
          center_y: percent_y(50),
          circle_radius: percent_y(40),
          number_radius: percent_y(40) * 1.2,
          needle_length: percent_y(40) * 0.9
        }
      end

      def draw_components(dimensions)
        {
          circle: draw_circle(dimensions),
          number_texts: draw_numbers(dimensions),
          needle: draw_needle(dimensions),
          labels: draw_labels(dimensions)
        }
      end

      def draw_circle(dimensions)
        Circle.new(
          x: dimensions[:center_x],
          y: dimensions[:center_y],
          radius: dimensions[:circle_radius],
          sectors: 100,
          color: @outer_circle_color,
          z: 0
        )
      end

      def draw_numbers(dimensions)
        number_texts = {}
        (0..99).each do |i|
          angle = i * (2 * Math::PI / 100) - Math::PI / 2
          x = dimensions[:center_x] + Math.cos(angle) * dimensions[:number_radius]
          y = dimensions[:center_y] + Math.sin(angle) * dimensions[:number_radius]
          number_texts[i] = Text.new(
            i.to_s, x: x - 15, y: y - 15,
                    size: 28, color: @number_color, z: 1
          )
          number_texts[i].remove # Hide the number initially
        end
        number_texts
      end

      def draw_needle(dimensions)
        Triangle.new(
          x1: dimensions[:center_x],
          y1: dimensions[:center_y],
          x2: dimensions[:center_x] - 10,
          y2: dimensions[:center_y] - dimensions[:needle_length],
          x3: dimensions[:center_x] + 10,
          y3: dimensions[:center_y] - dimensions[:needle_length],
          color: @needle_color,
          z: 2
        )
      end

      def draw_labels(dimensions)
        {
          zero_count_label: Text.new(
            "Zero Counts: 0",
            x: dimensions[:center_x],
            y: dimensions[:center_y] - dimensions[:circle_radius] - percent_y(10), # Adjusted offset
            size: 50,
            color: @zero_count_color
          ),
          distance_label: Text.new(
            "Distance: 0",
            x: dimensions[:center_x],
            y: dimensions[:center_y] - dimensions[:circle_radius] - percent_y(6), # Adjusted offset
            size: 50,
            color: @distance_color
          ),
          clock_label: Text.new(
            "Time: 00:00",
            x: percent_x(5),
            y: percent_y(95),
            size: 30,
            color: @clock_color
          )
        }
      end

      def start_animation(components, dimensions)
        animate_needle(
          components[:needle],
          components[:labels],
          components[:circle],
          components[:number_texts],
          dimensions
        )
      end

      def animate_needle(needle, labels, circle, number_texts, dimensions)
        return if @data.nil? || @data.empty?

        initialize_animation_state
        Window.update do
          update_clock(labels[:clock_label])
          if Time.now - @last_update_time >= @animation_speed
            update_needle(needle, labels, circle, number_texts, dimensions)
            @last_update_time = Time.now
          end
        end
      end

      def initialize_animation_state
        @current_index = 0
        @last_update_time = Time.now
        @start_time = Time.now
        @previous_position = nil
        @current_position = @data.first[:position] # Start at the initial position
      end

      def update_clock(clock_label)
        elapsed_time = Time.now - @start_time
        minutes = (elapsed_time / 60).floor
        seconds = (elapsed_time % 60).floor
        clock_label.text = format("Time: %02d:%02d", minutes, seconds)
      end

      def update_needle(needle, labels, circle, number_texts, dimensions)
        # Hide the previous number
        number_texts[@previous_position]&.remove if @previous_position

        # Show the current number
        current_number = number_texts[@current_position]
        current_number&.add

        # Update stats
        labels[:zero_count_label].text = "Zero Counts: #{@data[@current_index][:zero_counts]}"
        labels[:distance_label].text = "Distance: #{@data[@current_index][:distance]} | Direction: #{@data[@current_index][:direction]}"

        # Animate the needle toward the new position
        angle = @current_position * (2 * Math::PI / 100) - Math::PI / 2
        needle.x2 = circle.x - 10 + Math.cos(angle) * dimensions[:needle_length]
        needle.y2 = circle.y + Math.sin(angle) * dimensions[:needle_length]
        needle.x3 = circle.x + 10 + Math.cos(angle) * dimensions[:needle_length]
        needle.y3 = circle.y + Math.sin(angle) * dimensions[:needle_length]

        # Highlight if crossing zero
        needle.color = @previous_position.nil? || (@previous_position == 99 && @current_position.zero?) ? @needle_highlight_color : @needle_color

        # Move to the next data point
        @previous_position = @current_position
        @current_index = (@current_index + 1) % @data.length
        @current_position = @data[@current_index][:position]
      end

      # Helper method to calculate x position as a percentage of the window width
      def percent_x(percent)
        Window.width * (percent / 100.0)
      end

      # Helper method to calculate y position as a percentage of the window height
      def percent_y(percent)
        Window.height * (percent / 100.0)
      end
    end
  end
end
