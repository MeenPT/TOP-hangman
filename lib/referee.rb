module Referee
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
end
