require_relative 'options.rb'
require 'json'
class Main


  def initialize
    @game_over=false
    @win = false
    @game_options = GameOptions.new(@sample_word,@word_discover_array,@number_of_shots,@number_of_tries, @latters)
    qualified_words_array
    display
  end


  def qualified_words_array
    @number_of_tries = 0
    @qualified_words = []
    @five_desk_file_location= Dir.glob("../5desk.txt").first
    five_desk= File.open(@five_desk_file_location)
    five_desk.each do |line|
      if (line.length>4)&&(line.length<13)
        @qualified_words<<line.chomp.downcase
      end
    end
    @sample_word=@qualified_words.sample
    @latters=@sample_word.split("")
  end

  def display
    @word_discover_array=[]
    (@sample_word.length).times{ @word_discover_array << "_"}
    @user_input = gets.chomp.to_s.downcase
    validate_user_input
  end

  def play
    @number_of_shots = @sample_word.length+5 - @number_of_tries
    puts "you have #{@number_of_shots} shots"
    p @word_discover_array
    check_game_over?
    check_win?
    while (@game_over==false) && (@win==false)
      puts "please insert a latter between 'A - Z' "
      @user_input = gets.chomp.to_s.downcase
      validate_user_input
    end
  end


  def check_match
    @latters.each_with_index do |sample_word_latter, index|
      @word_discover_array[index]=@user_input if @user_input == sample_word_latter
    end
    play
  end

  def check_game_over?
    if @number_of_tries>=(@sample_word.length+5)
      puts "GAME OVER!"
      @game_over=true
    end
    @number_of_tries +=1
  end

  def check_win?
    if !@word_discover_array.include?"_"
      puts "YOU WIN THE GAME!"
      @win=true
    end
  end
  def validate_user_input
    case @user_input
      when "a".."z"
        check_match
      when "0"
        puts "Do you want to exit the game? Replay: Yes/No"
        exit_game=gets.chomp.downcase
        if exit_game=="yes"
          new_game= Main.new
        elsif exit_game=="no"
          @number_of_tries-=1
          play
        end
        play if @number_of_tries=0
      when "1"
        play if @number_of_tries=0
      when "2"
        @game_options.to_json(@sample_word, @word_discover_array, @number_of_shots,@number_of_tries ,@latters)
        @game_options.save_game
        play
      when "3"
        @game_options.load_game
        @sample_word=@game_options.sample_word
        @word_discover_array=@game_options.word_discover_array
        @number_of_shots= @game_options.number_of_shots
        @number_of_tries = @game_options.number_of_tries
        @latters=@game_options.latters
        play
      else
        puts "please insert a latter between A-Z"
        @user_input=gets.chomp.to_s.downcase
    end
  end
end

start_game= Main.new










