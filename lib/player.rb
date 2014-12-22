require_relative "scoresheet.rb"
require 'set'

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
		turn_over = false
		(1..3).each do |i|
			display_dice(i)
			turn_over = user_input(i)
			break if turn_over
		end
	end

	def display_dice(i)
		dd = Array.new
		dd << ''.center(80, ?-) 
		dd << "Here are you dice. You have have #{3-i} rolls remaining.\n\n"
		dd << "\tDice\t\tZ\tX\tC\tV\tB"
		dd << "\tValues\t\t" + score.dice.values.map{|i| i.to_s}.join("\t")
		dd << ''.center(80, ?-)
		dd.each{|line| puts line}
	end

	def user_input(i) # @deprecated gets.chomp can cause unexpected results in some contexts
		if i < 3
			puts "Select dice to re-roll or select a score category."
		else
			puts "Select a score category."
		end
		input = gets.chomp.to_sym
		# If user wants to enter score
		if ScoreAbbr.keys.include?(input)
			score.enter_score(ScoreAbbr[input])
			return true
		# # Else if user wants to roll the dice
		# elsif i < 3 && Set.new(input.downcase).subset?(Set.new(["zxcvb".split('')]))
		# 	# Roll dice - need to write code here
		# 	return false
		else
			puts "Invalid input."
			user_input(i)
		end
	end
				

end
 
