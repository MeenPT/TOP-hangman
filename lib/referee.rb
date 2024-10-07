module Referee
  WORDS = File.read('words.txt').split("\n")

  def game_result
    return 'lose' if remaining_attmpts < 1

    correct_answer_array = correct_answer.split('').uniq
    return 'win' if correct_answer_array.all? { |item| guess_history.include?(item) }

    nil
  end

  def alphabet?(text = '')
    return false if text.length > 1

    text.downcase.ord.between?('a'.ord, 'z'.ord)
  end

  def pick_word
    word = WORDS.sample

    return word if word.length.between?(5, 12)

    pick_word
  end
end
