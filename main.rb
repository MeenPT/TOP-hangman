require_relative 'lib/game'

saved_games = Game.load_saved_games

if saved_games.empty?
  game = Game.new
  game.start
else
  puts '0: New Game'
  saved_games.each_with_index do |saved_game, index|
    puts "#{index + 1}: #{saved_game[:thumbnail]}"
  end

  selected = gets.chomp.to_i
  if selected.zero?
    Game.new.start
  else
    picked_save = saved_games[selected - 1]
    Game.load_saved_game("#{picked_save[:@id]}.yaml").start
  end
end
