require_relative "dice.rb"
require_relative "scoring.rb"

class Calculator
	extend Scoring
end

class ScoreSheet # Keeps score throughout the game
	
	include Scoring
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
	def enter_score(field)
		if field == :yahtzee && ((available :yahtzee) || @num_yahtzees > 0)
			@sheet[field] = yahtzee, true
		elsif available field			
			calculator = Calculator.new
			@sheet[field] = Calculator.send(field, @dice.values), true
		else
			raise "Score already entered."
		end
	end

=begin
@return [true] if the score sheet is completely filled and no legal moves remain
@return [false] if the score sheet is not completely filled and there are still legal moves to be made
=end
	def filled?; @sheet.collect{|k,v| v[1]}.reduce{|r,e| r && e}; end
	
	def raw_upper; @sheet.select{|x| UpperScores.include? x }.collect{|k,v| v[0]}.reduce :+; end	# @return [Fixnum]	

	def upper_score_total; raw_upper + upper_score_bonus; end	# @return [Fixnum] the total score of the upper part of the ScoreSheet, including bonuses
	def lower_score_total; @sheet.select{|x| LowerScores.include? x }.collect{|k,v| v[0]}.reduce :+; end	# @return [Integer] The total score of the lower part of the ScoreSheet
	def total; lower_score_total + upper_score_total; end # @return [Integer] the grand total
	


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

	
	private # Helper methods

	def available (field); @sheet[field][1] == false; end

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
public
	alias display to_s
end
