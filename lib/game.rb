require_relative "player.rb"

class Game
	user = Player.new

	until user.score.filled? do
		puts "\n"
		puts "New Turn".center(80)
		puts "\n"
		sleep 0.5
		user.take_turn
	end
end
