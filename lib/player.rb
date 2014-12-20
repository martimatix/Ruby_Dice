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
			display_dice(i)
			puts "Select dice to re-roll or select a score category."
			input = gets.chomp
		end
	end

	def display_dice(i)
		dd = Array.new
		dd << ''.center(80,'-') 
		dd << "Here are you dice. You have have #{3-i} rolls remaining.\n\n"
		dd << "\tDice\t\tZ\tX\tC\tV\tB"
		dd << "\tValues\t\t" + score.dice.values.map{|i| i.to_s}.join("\t")
		dd << ''.center(80,'-')
		dd.each{|line| puts line}
	end

end
 