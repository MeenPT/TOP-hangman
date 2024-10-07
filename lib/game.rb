require 'yaml'
require_relative 'display'
require_relative 'referee'

class Game
  attr_accessor :id, :correct_answer, :remaining_attmpts, :guess_history

  SAVE_DIR = 'saved_games'.freeze

  include Referee
  include Display

  def initialize(id = Time.now.to_i, correct_answer = pick_word, remaining_attmpts = 11, guess_history = [])
    self.id = id
    self.correct_answer = correct_answer
    self.remaining_attmpts = remaining_attmpts
    self.guess_history = guess_history
  end

  def start
    loop do
      display_censored_answer
      annouce_remaining_attempts
      accquire_user_guess

      if game_result == 'win' || game_result == 'lose'
        delete_save
        break
      end
    end

    puts "You #{game_result}"
  end

  def accquire_user_guess
    puts 'Guess a letter (type "quit" to quit):'
    guess = gets.chomp.downcase

    if guess == 'quit'
      save_game
      exit
    end

    unless alphabet?(guess)
      puts 'Invalid character. Please pick a letter.'
      accquire_user_guess
    end

    guess_history.push(guess)

    return if correct_answer.include?(guess)

    self.remaining_attmpts -= 1
  end

  def save_game
    Dir.mkdir(SAVE_DIR) unless Dir.exist?(SAVE_DIR)

    game_states = {}

    censored_array = correct_answer.split('').map do |letter|
      guess_history.include?(letter) ? letter : '_'
    end

    game_states[:thumbnail] = censored_array.join

    instance_variables.each do |var|
      game_states[var] = instance_variable_get(var)
    end

    game_states_yaml = YAML.dump(game_states)

    File.open("#{SAVE_DIR}/#{id}.yaml", 'w') { |file| file.write(game_states_yaml) }
  end

  def self.load_saved_games
    dir = Dir.new(SAVE_DIR)
    saved_games = dir.map do |filename|
      YAML.load_file("#{SAVE_DIR}/#{filename}") if filename.end_with?('.yaml')
    end.compact

    p saved_games
  end

  def self.load_saved_game(filename)
    data = YAML.load_file("#{SAVE_DIR}/#{filename}")
    new(data[:@id], data[:@correct_answer], data[:@remaining_attmpts], data[:@guess_history])
  end

  def delete_save
    file_path = "#{SAVE_DIR}/#{id}.yaml"
    File.unlink(file_path) if File.exist?(file_path)
  end
end
