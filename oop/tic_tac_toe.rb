require_relative 'game_board'
require_relative 'player'

class TicTacToe
  attr_accessor :player1, :player2, :gameboard, :player1turn

  def initialize(name1, name2)
    @player1 = Player.new(name1)
    @player2 = Player.new(name2)
    @gameboard = GameBoard.new
    @player1turn = true
  end

  def play
    instructions
    start
  end

  def instructions
    puts "Instructions:"
    puts "The game will prompt you when it is your turn."
    puts "Each position on the Tic-Tac-Toe board is represented by a letter A through I."
    puts "Type in the letter corresponding to the area you wish to mark."
    puts "\n\nLet's begin then, #{@player1.name} and #{@player2.name}!\n\n"
  end

  def start
    turns = 0
    while gameboard.win == false && turns < 9
      next_turn
      switch_turns
      gameboard.check_for_win
      turns += 1
    end
    turns > 8 ? draw : someone_won
  end

  def switch_turns
    @player1turn = !@player1turn
  end

  def next_turn
    @player1turn ? gameboard.update_with(player1.turn, @player1turn) : gameboard.update_with(player2.turn,false)
  end

  def someone_won
    puts @player1turn ? "#{player2.name} has won! Suck it, #{player1.name}!" : "#{player1.name} has won! Suck it, #{player2.name}!"
  end

  def draw
    puts "It's a draw. You both suck! Haha!"
  end
end



def get_player_name(number)
  print "Hello, Player #{number}! What should we call you?? "
  @name = gets.chomp
  puts "\n"
  @name
end


puts "Starting a Game of Tic Tac Toe!"
game = TicTacToe.new(get_player_name(1), get_player_name(2))
game.play