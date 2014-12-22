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
		dd << "Here are your dice. You have have #{3-i} #{i==2? "roll":"rolls"} remaining.\n\n"
		dd << "\tDice\t\tZ\tX\tC\tV\tB"
		dd << "\tValues\t\t" + score.dice.values.map{|i| i.to_s}.join("\t")
		dd << ''.center(80, ?-)
		dd.each{|line| puts line}
	end
=begin
@param i [Fixnum] Amount of times rolled
@return [Boolean, void]
@deprecated gets.chomp can cause unexpected results in some contexts
=end
	def user_input(i)
		if i < 3
			puts "Select dice to re-roll or select a score category."
		else
			puts "No rolls remaining. Select a score category."
		end

		input = gets.chomp.downcase
		input_symbol = input.to_sym
		user_input_set = Set.new(input.split(''))
		dice_controls = "zxcvb".split('')
		set_of_dice_controls = Set.new(dice_controls)

		# If user wants to enter score
		if ScoreAbbr.keys.include?(input_symbol)
			score.enter_score(ScoreAbbr[input_symbol])
			return true
		# Else if user wants to roll the dice
		elsif i < 3 && (user_input_set.subset? set_of_dice_controls)
			dice_to_roll = (0..4).to_a.select { |i| input.include? dice_controls[i]}
			@score.dice.roll(dice_to_roll)
			puts " Rolling Dice! ".center(80,"* ")
			return false 
		else
			puts "Invalid input."
			user_input(i)
		end
	end
				

end
 
