module Display
  def display_censored_answer
    censored_array = correct_answer.split('').map do |letter|
      guess_history.include?(letter) ? letter : '_'
    end

    puts censored_array.join
  end

  def annouce_remaining_attempts
    puts "Remaining attempts: #{remaining_attmpts}"
  end
end
