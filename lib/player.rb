require_relative "scoresheet.rb"

class Player
	ScoreAbbr = {?1.to_sym => :ones, ?2.to_sym => :twos, ?3.to_sym => :threes, ?4.to_sym => :fours, ?5.to_sym => :fives, 
	?6.to_sym => :sixes, ss: :small_straight, ls: :large_straight, tok: :three_of_a_kind, fok: :four_of_a_kind, 
	fh: :full_house, y: :yahtzee, "?".to_sym => :chance}
	attr_reader :score # @return [ScoreSheet]

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
