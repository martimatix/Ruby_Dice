class Dice # Class for a die in the game
	attr_reader :num
	Faces = [1, 2, 3, 4, 5, 6] # Every face on the dice
	def initialize; @num = Faces.sample; end
	def roll; @num = Faces.sample; end # Rolls the dice
	alias to_s num
end
class FiveDice # Class for working with the 5 dice at the same time
	attr_reader :dice # The dice in the game
	def initialize
		@dice = Array.new
		5.times {@dice.push Dice.new}
	end
	def roll(i); @dice[i].roll; end # Rolls the die at the index i
	def roll_all # Rolls all the dice
		for die in @dice; die.roll; end
	end
	def display # Display instance variable dice
		@dice.each {|i| puts i}
		puts "\n"
	end
end
# testing
d = FiveDice.new

d.roll_all
d.display
d.sort
d.display


