class AdventOfCode2025::Solvers::Three < AdventOfCode2025::Solvers::Base
  Batery = Struct.new("Batery", :pos, :val)

  private

  def solve_part_1
    joltages = []
    @input.each_line do |line|
      power_bank_number_values = line.chomp.chars.map(&:to_i)
      max_value = power_bank_number_values[0..-2].max

      index_of_max_value = power_bank_number_values.index(max_value)
      second_max_value = power_bank_number_values[index_of_max_value + 1..].max

      joltages << [max_value.to_s, second_max_value.to_s].join.to_i
    end
    joltages.sum
  end

  def solve_part_2
    # 9 8 7 6 5 4 3 2 1 1  1  1   1   1   1
    # 1 2 3 4 5 6 7 8 9 10 11 12  13  14  15
    #
    # 8 1 1 1 1 1 1 1 1 1  1  1   1   1   9
    # 1 2 3 4 5 6 7 8 9 10 11 12  13  14  15
    #
    # 2 3 4 2 3 4 2 3 4 2  3  4   2   7   8
    # 1 2 3 4 5 6 7 8 9 10 11 12  13  14  15
    #
    # 8 1 8 1 8 1 9 1 1 1  1  2  1  1  1
    # 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
    lines = @input.each_line.map do |l|
      l.chomp.chars.map(&:to_i).map.with_index do |v, i|
        Batery.new(i + 1, v)
      end
    end
    joltages = []
    total_jolts = 12
    lines.each do |line|
      line_max_pos = line.max_by(&:pos).pos
      line_jols = []

      left_min_pos_pointer = 0
      (1..total_jolts).to_a.reverse.each do |right_pointer|
        sub_line = line.select do |batery|
          batery.pos > left_min_pos_pointer && batery.pos + (right_pointer - 1) <= line_max_pos
        end
        max_jol = sub_line.max_by(&:val)

        left_min_pos_pointer = max_jol.pos

        line_jols << max_jol
      end

      l_joltage = line_jols.map(&:val).join.to_i
      joltages << l_joltage
    end
    joltages.sum
  end
end
