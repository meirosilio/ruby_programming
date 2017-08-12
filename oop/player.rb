class Player

  attr_accessor :name, :selected_values, :callback_valid_input, :player_input

  def initialize(number)
    @number=number
    @players_inputs=[]
  end

  def get_player_name(number)
    print "Player #{number}: What is your name?"
    puts " "
    player1_name = gets.chomp
    puts "wolecome #{player1_name}"
  end

  def game_instructions
    puts "player number #{@number}, it is your turn!"
    puts "choose number between 1-9:"
    puts "------------------------------ "
  end

  def user_input(counter)
    @callback_valid_input=false
    @player_input = gets.chomp.to_i
    if ((1..9).to_a.include? @player_input) && (!@players_inputs.include? @player_input)
      @players_inputs <<@player_input
      @callback_valid_input=true
    else
      case
        when @players_inputs.include?(@player_input)
          puts "this cell already taken"
          @callback_valid_input=false
        when !(1..9).to_a.include?(@player_input)
          puts "please insert number between 1-9"
          @callback_valid_input=false
        else
          puts "Some eror occured"
          @callback_valid_input=false
      end
    end
  end

end