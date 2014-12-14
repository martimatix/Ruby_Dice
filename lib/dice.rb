class Dice  # Class for working with the 5 dice at the same time
	attr_reader :values # @return [Array] the dice.
	def initialize; @values = Array.new(5) {new_dice}; end
	def roll(i); @values[i] = new_dice; end # Rolls the die at the index i
	def roll_all # Rolls all the dice
		for die in @values; die == new_dice; end
	end
	def display # @return [String] instance variable dice
		@values.each {|i| puts i}
		puts "\n"
	end
	# setting dice for values for testing
	def values=(values)
		# Check that values is an array of length 5 and that each value is a dice value
		@values = values if values.length == 5 && values.all? {|val| (val.is_a? Integer) && (val.between? 1,6)}
	end
	private 
	def new_dice; return (1..6).to_a.sample; end # @return [Fixnum] a random number between 1 and 6, inclusive
end
