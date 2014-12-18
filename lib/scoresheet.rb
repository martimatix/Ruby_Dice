require_relative "dice.rb"
class ScoreSheet
	UpperScores = :ones, :twos, :threes, :fours, :fives, :sixes # The fields on the top section of the score sheet
	LowerScores = :three_of_a_kind, :four_of_a_kind, :full_house, :small_straight, :large_straight, :chance, :yahtzee # The fields on the bottom section of the score sheet
	
	attr_reader :sheet # @return [Hash] table of two element arrays where the first value is the score and the second is whether the field has been played
	attr_reader :dice # @return [Dice]

=begin
@param custom_dice [Array<Fixnum>] custom dice for testing
=end
	def initialize(custom_dice=Array.new(5) {Dice.new.instance_eval "new_dice"})
		@sheet, @dice = Hash.new, Dice.new(custom_dice)
		Array.new(UpperScores).concat(LowerScores).each {|s| @sheet[s] = [0, false]}
	end
	
=begin
@param field [Symbol] is a score field on the yahtzee scoresheet
@return [void]
=end
	def enter_score(field); @sheet[field] = (send field), true; end

=begin
@return [Boolean] true if the score sheet is completely filled and no legal moves remain
@return [Boolean] false if the score sheet is not completely filled and there are still legal moves to be made
=end
	def filled?; @sheet.collect{|k,v| v[1]}.reduce{|r,e| r && e}; end # 
	
	def raw_upper; @sheet.select{|x| UpperScores.include? x }.collect{|k,v| v[0]}.reduce :+; end # @return [Fixnum]	

	def upper_score_total; raw_upper + upper_score_bonus; end # @return [Fixnum] The total score of the upper part of the ScoreSheet, including bonuses
	def lower_score_total; @sheet.select{|x| LowerScores.include? x }.collect{|k,v| v[0]}.reduce :+; end # @return [Integer] The total score of the lower part of the ScoreSheet
	def total; lower_score_total + upper_score_total; end # @return [Integer] The grand total
	
	def ones; 	return single_face 1	;end # @return [Fixnum] the total of all the ones
	def twos;	return single_face 2	;end # @return [Fixnum] the total of all the twos
	def threes;	return single_face 3	;end # @return [Fixnum] the total of all the threes
	def fours; 	return single_face 4	;end # @return [Fixnum] the total of all the fours
	def fives; 	return single_face 5	;end # @return [Fixnum] the total of all the fives
	def sixes; 	return single_face 6	;end # @return [Fixnum] the total of all the sixes

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
	def yahtzee; of_a_kind 5; end

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
Displays scoresheet
@return [String]
=end
	def to_s
		ss = String.new
		ss += %Q( S C O R E  S H E E T ).center(80, ?=) + "\n\n"
		(0..(UpperScores.length - 1)).each do |i|
			ss += ((format_score(UpperScores, i) + "\t\t" + format_score(LowerScores, i)).center(68) + ?\n)
		end
		ss += ("Bonus".ljust(20) + "#{upper_score_bonus}".rjust(3) + "\t\t" + format_score(LowerScores, LowerScores.length - 1)).center(68)
		ss += "\n\n"
		ss += "Total Score: #{total}".center(80) + ?\n
		ss += (?= * 80) + ?\n
		return ss
	end

	
	private # Helper methods for score calculation methods

=begin
calculates the score for the upper half fields of the score sheet
@param value [Integer] indicates which dice face is being counted
@return [Fixnum]
dice.select{|number| number == value} filters the value
reduce(:+) sums the array
=end
	def single_face(value)
		 v = @dice.values.select{|number| number == value}.reduce(:+)
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

	def mode; return freq.max_by{|k,v| v}; end # @return [Array] a 2 element array with the mode and model frequency

=begin
helper method for calculating the scores of three of a kind, four of a kind and yahtzee
Use limit = 3 for three of a kind, limit = 4 for four of a kind and limit = 5 for yahtzee
@return [Fixnum]
=end
	def of_a_kind(limit)
		model_value, mode_f = mode
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
=end
	def format_score(score_region, index)
		# Remove underscores with spaces
		score_label = "#{score_region[index]}".tr(?_, " ")
		# Capitalize each letter of each word only if the score label has two words
		if score_label.split.length == 2
			score_label = score_label.split.map(&:capitalize)*' '
		# Else only capitalize the first letter of the score label
		else; score_label = score_label.capitalize
		end
		return score_label.ljust(20) + "#{@sheet[score_region[index]][0]}".rjust(3)
	end
	alias display to_s
end
