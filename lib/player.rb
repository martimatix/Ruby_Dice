require_relative "scoresheet.rb"
require 'set'

class Player
	
	ScoreAbbr = { # Abbreviations used in-game
		?1.to_sym => :ones,
		?2.to_sym => :twos,
		?3.to_sym => :threes,
		?4.to_sym => :fours,
		?5.to_sym => :fives,
		?6.to_sym => :sixes,
		ss: :small_straight,
		ls: :large_straight,
		tok: :three_of_a_kind,
		fok: :four_of_a_kind,
		fh: :full_house,
		y: :yahtzee,
		"?".to_sym => :chance
	}

	attr_reader :score # @return [ScoreSheet]

	def initialize
		@score = ScoreSheet.new
	end

=begin
@todo finish method
@return [void]
=end
	def take_turn
		turn_over = false
		(1..3).each do |i|
			display_dice i
			turn_over = user_input i 
			break if turn_over
		end
	end

	def display_dice(i)
		dd = Array.new
		dd << String.new.center(80, ?-) 
		dd << "Here are your dice. You have have #{3-i} #{i==2? "roll":"rolls"} remaining.\n\n"
		dd << "\tDice\t\tZ\tX\tC\tV\tB"
		dd << "\tValues\t\t" + score.dice.values.map{|value| value.to_s}.join(?\t)
		dd << String.new.center(80, ?-)
		dd.each do |line|
			puts line
			sleep 0.2
		end
	end
=begin
@param i [Fixnum] Amount of times rolled
@return [Boolean]
@note Gameplay
=end
	def user_input(i)
		if i < 3
			print "Select dice to re-roll or select a score category: "
		else
			print "No rolls remaining. Select a score category: "
		end
		input = gets.chomp.downcase
		input_symbol = input.to_sym
		user_input = Set.new(input.split(''))
		dice_controls = Set.new("zxcvb".split(''))

		# If user wants to enter score
		if ScoreAbbr.keys.include? input_symbol
			score.enter_score ScoreAbbr[input_symbol]
			puts score
			@score.dice.roll_all
			sleep 2
			return true
		# Else if user wants to roll the dice
		elsif i < 3 && (user_input.subset? dice_controls)
			dice_to_roll = (0..4).to_a.select { |index| input.include? dice_controls.to_a[index]}
			@score.dice.roll(dice_to_roll)
			sleep 0.5
			2.times {puts ?\n}
			puts " Rolling Dice!\ ".center 80, "* "
			sleep 1
			return false 
		else
			puts "Invalid input. Please try again."
			sleep 1.5
			puts ?\n
			user_input i
		end
	end
end
 
