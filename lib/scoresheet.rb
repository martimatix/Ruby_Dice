require_relative "dice.rb"
class ScoreSheet # Keeps score throughout the game
	UpperScores = :ones, :twos, :threes, :fours, :fives, :sixes	# The fields on the top section of the score sheet
	LowerScores = :three_of_a_kind, :four_of_a_kind, :full_house, :small_straight, :large_straight, :chance, :yahtzee	# The fields on the bottom section of the score sheet
	
	attr_reader :sheet	# @return [Hash] table of two element arrays where the first value is the score and the second is whether the field has been played
	attr_reader :dice	# @return [Dice]
	attr_reader :num_yahtzees	# @return [Fixnum] counter for number of yahtzees scored in the game

=begin
@param custom_dice [Array<Fixnum>] custom dice for testing
=end
	def initialize(custom_dice=Array.new(5) {Dice.new.instance_eval "new_dice"})
		@sheet, @dice, @num_yahtzees = Hash.new, Dice.new(custom_dice), 0
		Array.new(UpperScores).concat(LowerScores).each {|s| @sheet[s] = [0, false]}
	end
	
=begin
@param field [Symbol]
@return [void]
=end
	def enter_score(field); @sheet[field] = (send field), true; end

=begin
@return [Boolean] true if the score sheet is completely filled and no legal moves remain
@return [Boolean] false if the score sheet is not completely filled and there are still legal moves to be made
=end
	def filled?; @sheet.collect{|k,v| v[1]}.reduce{|r,e| r && e}; end
	
	def raw_upper; @sheet.select{|x| UpperScores.include? x }.collect{|k,v| v[0]}.reduce :+; end	# @return [Fixnum]	

	def upper_score_total; raw_upper + upper_score_bonus; end	# @return [Fixnum] the total score of the upper part of the ScoreSheet, including bonuses
	def lower_score_total; @sheet.select{|x| LowerScores.include? x }.collect{|k,v| v[0]}.reduce :+; end	# @return [Integer] The total score of the lower part of the ScoreSheet
	def total; lower_score_total + upper_score_total; end # @return [Integer] the grand total
	
	def ones; return single_face 1; end 	# @return [Fixnum]
	def twos; return single_face 2; end	# @return [Fixnum]
	def threes; return single_face 3; end 	# @return [Fixnum] the total of all the threes
	def fours; return single_face 4; end 	# @return [Fixnum] the total of all the fours
	def fives; return single_face 5; end 	# @return [Fixnum] the total of all the fives
	def sixes; return single_face 6; end 	# @return [Fixnum] the total of all the sixes

=begin
Checks if upper score bonus can be awarded
@return [Fixnum] 0 if raw_upper < 63
@return [Fixnum] 35 if raw_upper >= 63
=end
	def upper_score_bonus
		if raw_upper >= 63 then return 35
		else; return 0
		end
	end
=begin
@return [Fixnum]
Checks to see if you have all the of the same dice
=end
	def yahtzee
		if dice.values.all? {|x| x == dice.values[0]}
			@num_yahtzees += 1
			return sheet[:yahtzee][0] + 50 * 2 ** (@num_yahtzees - 1)
		else; return 0
		end
	end
=begin
Checks to see if you have 3 of the same dice
@return [Fixnum] @dice.dice.reduce(:+) if there is <= 3 of the same value
@return [Fixnum] 0 if you do not have a three of a kind
=end
	def three_of_a_kind; of_a_kind 3; end

=begin
Checks to see if you have 4 of the same dice
@return [Fixnum]  0 if <= 4 indices have the same value
@return [Fixnum]  @dice.dice.reduce(:+) if >= 4 indices have the same value
=end
	def four_of_a_kind; of_a_kind 4; end 

=begin
Checks to see if you have 3 of one kind of dice and 2 of another
@return [Fixnum] 25 if @dice.dice contains 3 of one Fixnum and 2 of another
@return [Fixnum] 0 if @dice.dice does not contain 3 of one Fixnum and 2 of another
=end
	def full_house
		f_table = freq
		if (f_table.length == 2 && f_table.has_value?(3)) || f_table.length == 1 then return 25			
		else; return 0
		end
	end

	def small_straight; straight 4, 30; end # @return [Fixnum]
	def large_straight; straight 5, 40; end # @return [Fixnum] 
	
	def chance; @dice.values.reduce :+; end # @return [Fixnum] the sum of all the dice

=begin
	@todo Find a less complex way to create final string
	@return [String]
	
=end
	def to_s
		ss = String.new
		ss += %Q( S C O R E  S H E E T ).center(80, ?=) + "\n\n"
		(0..(UpperScores.length - 1)).each do |i|
			ss += print_score_sheet_line(i)
		end
		ss += bonus_yahtzee_line
		ss += "\n\n"
		ss += "Total Score: #{total}".center(80) + ?\n
		ss += (?= * 80) + ?\n
		return ss
	end

	
	private # Helper methods for score calculation and printing

	def score_sheet_line(left_val, right_val); (left_val + "\t\t" + right_val).center(68) + ?\n; end
	alias ssl score_sheet_line
	
	def print_score_sheet_line(i);
		upper, lower = format_score(UpperScores, i), format_score(LowerScores, i)
		ssl upper, lower
	end
	

	def bonus_yahtzee_line
		bonus_string, yahtzee_string = justify_score("Bonus", upper_score_bonus.to_s), format_score(LowerScores, LowerScores.length - 1)
		ssl bonus_string, yahtzee_string
	end
	alias byl bonus_yahtzee_line
=begin
calculates the score for the upper half fields of the score sheet
@param value [Integer] indicates which dice face is being counted
@return [Fixnum]
dice.select{|number| number == value} filters the value
reduce(:+) sums the array
=end
	def single_face(value)
		 v = @dice.values.select{|number| number == value}.reduce :+
		 unless v.nil?; return v
		 else; return 0
		 end
	end
=begin
@return [Hash] a frequency hash table
@example
	freq #=> {1=>3, 2=>1, 3=>1}
=end
	def freq; return @dice.values.inject(Hash.new(0)) { |h,v| h[v] += 1; h }; end

	def mode; return freq.max_by{|k,v| v}; end # @return [Array] a 2 element array with the mode and modal frequency

=begin
helper method for calculating the scores of three of a kind and four of a kind
Use limit = 3 for three of a kind, limit = 4 for four of a kind
@param limit [Integer]
@return [Fixnum]
=end
	def of_a_kind(limit)
		modal_value, mode_f = mode
		if mode_f >= limit then return @dice.values.reduce :+
		else; return 0
		end
	end
=begin
@param limit [Fixnum] = 4 for small straight
@param limit [Fixnum] = 5 for large straight
common code for both small straight (SS) and large straight (LS)
@param score [Fixnum] is the score to return
@return [Fixnum] 
=end
	def straight(limit, score) 
		#each_cons is generating every possible value for a straight of length limit
		(1..6).each_cons(limit).each do |i|
			# Asking if i is a subset of dice
			if (i - @dice.values).empty?
				return score if (i - @dice.values)
			end
		end
		return 0
	end
=begin
@return [String] the formatted string
@param index [Fixnum]
@param score_region [String, Array<String>]
Replace underscores with spaces
=end
	def format_score(score_region, index)
		score_label = "#{score_region[index]}".tr(?_, " ")
		cap_label score_label
		score_field = @sheet[score_region[index]]
		return justify_score(score_label, "#{score_field[1]? score_field[0]:?-}")
	end

	def justify_score(label, score); label.ljust(20) + score.rjust(3); end

=begin
@param score_label [String]
@return [String]
Capitalize each letter of each word only if the score label has two words
Else only capitalize the first letter of the score label
=end
	def cap_label(score_label)
		if score_label.split.length == 2
			score_label = score_label.split.map(&:capitalize)*' '
		else; score_label.capitalize!
		end
	end
	alias display to_s
end
