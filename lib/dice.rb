class Dice  # Class for working with the 5 dice at the same time
	attr_accessor :dice # @return [Array] the dice.
	def initialize; @dice = Array.new(5) {new_dice}; end
	def roll(i); @dice[i] = new_dice; end # Rolls the die at the index i
	def roll_all # Rolls all the dice
		for die in @dice; die == new_dice; end
	end
	def display # Display instance variable dice
		@dice.each {|i| puts i}
		puts "\n"
	end
	private 
	def new_dice; return (1..6).to_a.sample; end # Returns a random number between 1 and 6, inclusive
end
