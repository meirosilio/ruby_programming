
class GameBoard
  attr_accessor :values, :win

  def initialize
    @values = (1..9).to_a
    @win = false
    display
  end

  def display
    @values.each_with_index do |value, index|
      if index % 3 == 2
        print index == 8 ? "#{value}\n" : "#{value}\n----------\n"
      else
        print "#{value} | "
      end
    end
    puts " "
  end

  def update_with(position, turn=false)
    p position
    @values.each_with_index do |value, index|
      if value == position
        @values[index] = turn ? "X" : "O"
        display
      end
    end
  end

  def check_for_win
    @win = true if values[0] == values[1] && values[1] == values[2]
    @win = true if values[3] == values[4] && values[4] == values[5]
    @win = true if values[6] == values[7] && values[7] == values[8]
    @win = true if values[0] == values[3] && values[3] == values[6]
    @win = true if values[1] == values[4] && values[4] == values[7]
    @win = true if values[2] == values[5] && values[5] == values[8]
    @win = true if values[0] == values[4] && values[4] == values[8]
    @win = true if values[2] == values[4] && values[4] == values[6]
  end
end

