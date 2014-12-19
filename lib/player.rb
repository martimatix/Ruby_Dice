require_relative "scoresheet.rb"

class Player

	attr_reader :score

	def initialize; @score = ScoreSheet.new; end

=begin
@todo finish method
@return [void]
=end
	def take_turn
		(1..3).each do |i|
			puts "Your current stats: \n#{@score.dice.to_s}"
			puts "You have #{3-i} rolls remaining. Select dice to re-roll or select a score field."
			input = gets.chomp
		end
	end
end
