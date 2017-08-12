class Board

  attr_accessor :win

  def initialize
    @game_options = (1..9).to_a
    @players_inputs=[]
    @win = false
  end

  def draw_board
   @game_options.each_with_index do |cell,index|
     if (index==2)||(index==5)||(index==8)
       puts cell
     else
       print "#{cell}|"
     end
   end
  end

  def switch_player(player_input, counter)
    if (counter%2==0)&& (counter<9)
      @game_options[player_input-1]="X"
      draw_board
    elsif counter>8
      @game_options[player_input-1]="X"
      draw_board
    else
      @game_options[player_input-1]="O"
      draw_board
    end
  end

  def check_winner?
    @win = true if @game_options[0] == @game_options[1] && @game_options[1] == @game_options[2]
    @win = true if @game_options[3] == @game_options[4] && @game_options[4] == @game_options[5]
    @win = true if @game_options[6] == @game_options[7] && @game_options[7] == @game_options[8]
    @win = true if @game_options[0] == @game_options[3] && @game_options[3] == @game_options[6]
    @win = true if @game_options[1] == @game_options[4] && @game_options[4] == @game_options[7]
    @win = true if @game_options[2] == @game_options[5] && @game_options[5] == @game_options[8]
    @win = true if @game_options[0] == @game_options[4] && @game_options[4] == @game_options[8]
    @win = true if @game_options[2] == @game_options[4] && @game_options[4] == @game_options[6]
  end

end
