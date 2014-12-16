class Dice  # Class for working with the 5 dice at the same time

	attr_reader :values # @return [Array] the dice.

	def initialize; @values = Array.new(5) {new_dice}; end

# @!group Roll Methods

=begin
@param i [Fixnum] index < 4
@raise [ArgumentError] if i > 4
@return [void]
=end
	def roll(i*)
		for index in i
			raise ArgumentError, "Illegal index" if index > 4
			@values[index] = new_dice
		end
	end 
	
=begin
@note Rolls all the dice
@return [void]
=end
	def roll_all; for die in @values; die = new_dice; end

# @!endgroup

	def to_s # @return [String] instance variable dice
		@values.each {|i| puts i}
		puts "\n"
	end
	alias display to_s

=begin
@param values [Array<Integer>]
@raise [ArgumentError] if values does not have 5 Integers that are between 1 and 6
@note setting dice for values for testing
@note checks that values is an Array of 5 elements and that each value is a Fixnum
@!parse attr_writer :values
=end
	def values=(values)
		if values.length == 5 && values.all? {|val| (val.is_a? Integer) && (val.between? 1,6)} then @values = values
		else; raise ArgumentError, "Array must have 5 Integers that are between 1 and 6"
		end
	end

	private 
	def new_dice; return (1..6).to_a.sample; end # @return [Fixnum] a random number between 1 and 6, inclusive
end
