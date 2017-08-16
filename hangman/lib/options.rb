require 'json'

class GameOptions
  attr_accessor :sample_word, :word_discover_array, :number_of_shots, :number_of_tries, :latters

  def initialize(sample_word, word_discover_array, number_of_shots, number_of_tries, latters)
    @word_discover_array=word_discover_array
    @number_of_shots=number_of_shots
    @sample_word=sample_word
    @number_of_tries=number_of_tries
    @latters=latters
    @save_name=" "
    instructions
  end

  def instructions
    puts "### Welcome To Hangman By Meir Rosilio###"
    puts " "
    puts "*****************************************"
    puts "* Input options:"
    puts "* 0 - exit game"
    puts "* 1 - new game"
    puts "* 2 - save game"
    puts "* 3 - load game"
    puts "*****************************************"
    puts "Enter your choice:"
  end

  def to_json (sample_word, word_discover_array, number_of_shots,number_of_tries,latters)
    @state = JSON.dump ({
        :sample_word => sample_word, :word_discover_array => word_discover_array, :number_of_shots => number_of_shots,
        :number_of_tries=>number_of_tries, :latters=> latters
    })
    @state
  end

  def from_json(string)
    data = JSON.parse(string)
    @sample_word = data['sample_word']
    @word_discover_array = data['word_discover_array']
    @number_of_shots = data['number_of_shots']
    @number_of_tries = data ['number_of_tries']
    @latters = data['latters']
  end

  def save_game
    Dir.mkdir('saves') unless Dir.exist? 'saves'
    puts "Name Your Saved Game: "
    save_name = gets.chomp
    Dir.chdir("saves")
    save_file = File.open(save_name,'w+')
    json_string = @state
    save_file.write(json_string)
    save_file.close
    puts "SAVED GAME SUCCESSFULY!"
  end

  def load_game
    if File.exist?('saves')
      Dir.foreach('saves') { |file| puts file unless file == '..' || file == '.'}

      picked_file=nil
      file_exist=false
      while file_exist==false
        puts "Please insert the last saved you want to load:"
        picked_file=gets.chomp
        Dir.foreach('saves') { |file| file_exist = true if file == picked_file}
        puts "Please pick an appropriate file name" if file_exist == false
      end
      file_path= "saves/#{picked_file}"
      saved_file = File.open(file_path)
      saved_file.each do |string|
      from_json(string)
      end
    end
  end
end



