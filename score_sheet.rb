# Class for Score Sheet
class Score_Sheet

	# Enter a score
	# Arguments: dice is an instance of the dice class
	#			 field is a score field on the yahtzee score sheet

	def enter_score(dice, field)
	end

	# ***Methods for calculating score***
	# The methods take an array of five ints as an argument

	# single_face calculates the score for the upper half fields of the score sheet
	# value indicates which dice face is being counted
	def single_face(dice, value)
		# dice.select{|number| number == value} filters the value
		# reduce(:+) sums the array
		return dice.select{|number| number == value}.reduce(:+)
	end

	def three_of_a_kind(dice)
		of_a_kind(dice, 3)
	end

	def four_of_a_kind(dice)
		of_a_kind(dice, 4)
	end

	def yahtzee(dice)
		of_a_kind(dice, 5)
	end

	def full_house(dice)
		f_table = freq(dice)
		if f_table.length == 2 && f_table.has_value?(3)
			return 25
		#edge case where a yahtzee is entered as a full house
		elsif f_table.length == 1
			return 25
		else
			return 0
		end
	end

	# small_straight and large_straight currently not working

	# def small_straight(dice)
	# 	if dice.each_cons(4).count >= 2
	# 		return 30
	# 	else
	# 		return 0
	# 	end
	# end

	# def large_straight(dice)
	# 		if dice.each_cons(5).count == 1
	# 		return 40
	# 	else
	# 		return 0
	# 	end
	# end
	


	# ***Helper methods for score calculation methods***

	# freq returns a frequency hash table
	def freq(dice)
		return dice.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
		#=> {1=>3, 2=>1, 3=>1}
	end

	# returns a 2 element array with the mode and modal frequency
	def mode(dice)
		return freq(dice).max_by{|k,v| v}
	end

	# helper method for calculating the scores of three of a kind, four of a kind and yahtzee
	# Use limit = 3 for three of a kind, limit = 4 for four of a kind and limit = 5 for yahtzee
	def of_a_kind(dice, limit)
		modal_value, mode_f = mode(dice)
		if mode_f >= limit
			return dice.reduce(:+)
		else
			return 0
		end
	end
		
end

# test
dice = [6, 6, 6, 6, 6]
ss = Score_Sheet.new()

puts ss.small_straight(dice)
