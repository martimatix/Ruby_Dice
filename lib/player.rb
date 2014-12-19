require scoresheet

class Player

	attr_reader: ss

	def intialize(scoresheet)
		@ss = scoresheet
	end

	def take_turn
		(1..3).each do |i|
			puts "Here are your dice"
			puts ss.dice.to_s
			puts "You have #{3-i} rolls remaining. Select dice to re-roll or select a score field."
		end
	end
end