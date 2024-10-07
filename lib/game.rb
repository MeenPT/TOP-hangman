require_relative 'display'
require_relative 'referee'

class Game
  attr_accessor :correct_answer, :remaining_attmpts, :guess_history

  include Referee
  include Display

  def initialize
    self.correct_answer = 'chicken'
    self.remaining_attmpts = 11
    self.guess_history = %w[c k]
  end

  def start
    loop do
      display_censored_answer
      annouce_remaining_attempts
      accquire_user_guess

      break if game_result == 'win' || game_result == 'lose'
    end

    puts "You #{game_result}"
  end

  def accquire_user_guess
    puts 'Guess a letter:'
    guess = gets.chomp.downcase

    unless alphabet?(guess)
      puts 'Invalid character. Please pick a letter.'
      accquire_user_guess
    end

    guess_history.push(guess)

    return if correct_answer.include?(guess)

    self.remaining_attmpts -= 1
  end
end
