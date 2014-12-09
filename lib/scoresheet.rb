require_relative "dice.rb"
class ScoreSheet # Class for Score Sheet
	
	@@upper_scores = :ones, :twos, :threes, :fours, :fives, :sixes
	@@lower_scores = :full_house, :small_straight, :large_straight, :three_of_a_kind, :four_of_a_kind, :yahtzee, :chance
	attr_reader :sheet # Hash table of two element arrays where the first value is the score and the second is whether the field has been played
	attr_reader :dice # The dice used
	def initialize
		@sheet, @dice = Hash.new, Dice.new
		Array.new(@@upper_scores).concat(@@lower_scores).each {|s| @sheet[s] = [0, false]}
	end
=begin
	Enter a score
			   field is a score field on the yahtzee score sheet
=end
	def enter_score(field); @sheet[field] = send field, @dice.dice; end
	def filled; @sheet.each{|x| x[1]}.all? {|x| x == true}; end # true if the score sheet is completely filled and no legal moves remain
	def raw_upper; @sheet.select{|x| @@upper_scores.include? x }.each{|x| x[1]}.reduce :+; end
	def upper_score_bonus # Check if upper score bonus can be awarded
		if raw_upper >= 63 then return 35
		else; return 0
		end
	end
	def upper_score_total; raw_upper + bonus; end
	def lower_score_total; @sheet.select{|x| @@lower_scores.include? x }.each{|x| x[1]}.reduce :+; end
	def total; lower_score_total + upper_score_total; end
		
	def ones; 	single_face 1	;end # The total of all the ones
	def twos;	single_face 2	;end # The total of all the twos
	def threes;	single_face 3	;end # The total of all the threes
	def fours; 	single_face 4	;end # The total of all the fours
	def fives; 	single_face 5	;end # The total of all the fives
	def sixes; 	single_face 6	;end # The total of all the sixes

	def three_of_a_kind; of_a_kind 3; end # Checks to see if you have a 3 of a kind
	def four_of_a_kind; of_a_kind 4; end

	def yahtzee; of_a_kind 5; end # Checks to see if all the dice are the same

	def full_house
		f_table = freq
		if f_table.length == 1..2 && f_table.has_value?(3) then return 25
		else; return 0
		end
	end

	def small_straight; straight 4, 30; end
	def large_straight; straight 5, 40; end

	def chance; @dice.dice.reduce :+; end
	
	private
=begin
	***Helper methods for score calculation methods***

	single_face calculates the score for the upper half fields of the score sheet
	value indicates which dice face is being counted
=end
	def single_face(value)
=begin
		@dice.select{|number| number == value} filters the value
		reduce(:+) sums the array
=end
		return @dice.dice.select{|number| number == value}.reduce(:+)
	end
	def freq # freq returns a frequency hash table
		return @dice.dice.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		#=> {1=>3, 2=>1, 3=>1}
	end

	def mode; return freq.max_by{|k,v| v}; end # returns a 2 element array with the mode and model frequency
=begin
	helper method for calculating the scores of three of a kind, four of a kind and yahtzee
	Use limit = 3 for three of a kind, limit = 4 for four of a kind and limit = 5 for yahtzee
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
	score is the score to return
=end
	def straight(limit, score)
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
	def display; end # displays score sheet
		
end
