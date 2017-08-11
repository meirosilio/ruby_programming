
class Player
  attr_accessor :name, :selected_values

  def initialize(name)
    @name = name
    @@selected_values = []
  end

  def turn
    prompt
    get_position
  end

  def prompt
    puts "#{name}, it's your turn now!"
  end

  def get_position
    position = gets.chomp.to_i
    while !(1..9).to_a.include?(position) || @@selected_values.include?(position) do
      case
        when @@selected_values.include?(position)
          puts "This spot is taken"
          position = gets.chomp.to_i
          p position
        when !(1..9).to_a.include?(position)
          puts "#{name} you need to insert a number between 1-9"
          position = gets.chomp.to_i
          p position
      end
    end
    @@selected_values << position
    position
    end
end