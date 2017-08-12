require_relative 'player'
require_relative 'board'
class Main

  def initialize
    @player1=Player.new(1)
    @player2=Player.new(2)
    @new_board = Board.new
  end

  def set_new_game
    @player1.get_player_name(1)
    @player2.get_player_name(2)
    @player1.game_instructions
    @new_board.draw_board
    play
  end
  def play
    counter=0

    p @new_board.win

    while (@new_board.win==false)  && (counter<9)
      @player1.user_input(counter)
      if @player1.callback_valid_input==true
        @new_board.switch_player(@player1.player_input, counter)
        counter+=1
      end
      @new_board.check_winner?
    end
    if (@new_board.win==true) && (counter<9)
      p counter
      if counter%2==0
        puts "2 won sldakds;ldaks;dk"
      else
        puts "1 won ------------------"
      end
    end
    if (counter==9) && (@new_board.win==false)
      puts "Game Over no one won the game"
    end
  end

end

new_game = Main.new
new_game.set_new_game

