require_relative "dice.rb"
class ScoreSheet
	UpperScores = :ones, :twos, :threes, :fours, :fives, :sixes
	LowerScores = :full_house, :small_straight, :large_straight, :three_of_a_kind, :four_of_a_kind, :yahtzee, :chance
	
	attr_reader :sheet # @return [Hash] table of two element arrays where the first value is the score and the second is whether the field has been played
	attr_reader :dice # @return [Dice]
=begin
Shortcut for dice.dice=
@param dice [Array<Fixnum>]
=end
	def initialize(custom_dice=nil)
		@sheet, @dice = Hash.new, Dice.new
		@dice.dice = custom_dice if custom_dice.is_a? Array
		Array.new(UpperScores).concat(LowerScores).each {|s| @sheet[s] = [0, false]}
	end
	
	def enter_score(field); @sheet[field] = (send field), true; end # @param field [Symbol] is a score field an the yahtzee scoresheet
	
	def filled?; @sheet.collect{|k,v| v[1]}.reduce{|r,e| r && e}; end # @return [Boolean] true if the score sheet is completely filled and no legal moves remain
	
	def raw_upper; @sheet.select{|x| UpperScores.include? x }.each{|x| x[1]}.reduce :+; end # @return [Fixnum]
=begin
Checks if upper score bonus can be awarded
@return [Fixnum]
=end
	def upper_score_bonus
		if raw_upper >= 63 then return 35
		else; return 0
		end
	end
	
	def upper_score_total; raw_upper + bonus; end # @return [Fixnum] The total score of the upper part of the ScoreSheet, including bonuses
	def lower_score_total; @sheet.select{|x| LowerScores.include? x }.each{|x| x[1]}.reduce(:+); end # @return [Fixnum] The total score of the lower part of the ScoreSheet
	def total; lower_score_total + upper_score_total; end # @return [Fixnum]
		
	def ones; 	return single_face 1	;end # @return [Fixnum] The total of all the ones
	def twos;	return single_face 2	;end # @return [Fixnum] The total of all the twos
	def threes;	return single_face 3	;end # @return [Fixnum] The total of all the threes
	def fours; 	return single_face 4	;end # @return [Fixnum] The total of all the fours
	def fives; 	return single_face 5	;end # @return [Fixnum] The total of all the fives
	def sixes; 	return single_face 6	;end # @return [Fixnum] The total of all the sixes

	def three_of_a_kind; of_a_kind 3; end # @return [Fixnum] Checks to see if you have 3 of the same dice
	def four_of_a_kind; of_a_kind 4; end # @return [Fixnum] Checks to see if you have 4 of the same dice

	def yahtzee; of_a_kind 5; end # checks to see if you have all the of the same dice
=begin
Checks to see if you have 3 of one kind of dice and 2 of another
@return [Fixnum]
=end
	def full_house # @return [Fixnum] the score; 25 if you have a full house and 0 if you don't
		f_table = freq
		if (f_table.length == 2 && f_table.has_value?(3)) || f_table.length == 1 then return 25			
		else; return 0
		end
	end

	def small_straight; straight 4, 30; end # @return [Fixnum]
	def large_straight; straight 5, 40; end # @return [Fixnum] 

	def chance; @dice.dice.reduce :+; end # @return [Fixnum] The sum of all the dice

	def to_s
		"hello world!"
		# Outputs score sheet
	end
	
	private # Helper methods for score calculation methods
=begin
single_face calculates the score for the upper half fields of the score sheet
@param value [Integer] indicates which dice face is being counted
@return [Fixnum]
=end
	def single_face(value)
=begin
		dice.select{|number| number == value} filters the value
		reduce(:+) sums the array
=end
		 v = @dice.dice.select{|number| number == value}.reduce(:+)
		 unless v.nil?; return v
		 else; return 0
		 end
	end
	def freq # @return [Hash] a frequency hash table
		return @dice.dice.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		#=> {1=>3, 2=>1, 3=>1}
	end

	def mode; return freq.max_by{|k,v| v}; end # @return [Array] a 2 element array with the mode and model frequency
=begin
	helper method for calculating the scores of three of a kind, four of a kind and yahtzee
	Use limit = 3 for three of a kind, limit = 4 for four of a kind and limit = 5 for yahtzee
	@return [Fixnum]
=end
	def of_a_kind(limit)
		model_value, mode_f = mode
		if mode_f >= limit then return @dice.dice.reduce :+
		else; return 0
		end
	end
=begin
	common code for both small straight (SS) and large straight (LS)
	limit = 4 for SS and limit = 5 for LS
	@param score [Fixnum] is the score to return
	
=end
	def straight(limit, score) # @return [Fixnum] 
		#each_cons is generating every possible value for a straight of length limit
		(1..6).each_cons(limit).each do |i|
			# Asking if i is a subset of dice
			if (i - @dice.dice).empty?
				return score if (i - @dice.dice)
			end
		end
		return 0
	end
	public
=begin
@todo Add definition
@return [Hash] 
=end
	def display; end
		
end
