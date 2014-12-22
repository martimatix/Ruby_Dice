class Dice  # Class for working with the 5 dice at the same time

	attr_reader :values # @return [Array] the dice.

	def initialize(values=Array.new(5) {new_dice}) # @param values [Array<Fixnum>] that contains 5 Fixnums
		check_dice values
		@values = values
	end 

# @!group Roll Methods

=begin
@raise [ArgumentError] if i element > 4
@return [void]
@param i [Array<Fixnum>] < 4
=end
	def roll(i)
		for index in i
			raise ArgumentError, "Illegal index" if index > 4
			@values[index] = new_dice
		end
	end 
	
=begin
@note Rolls all the dice

@return [void]
=end
	def roll_all
		for die in @values; die = new_dice; end
	end

# @!endgroup

	def to_s # @return [String] instance variable dice
		@values.each {|i| print "#{i}".center(16)}
		puts ?\n
	end
	alias display to_s

=begin
@param values [Array<Integer>]
@see (#check_dice)
@note setting dice for values for testing
@!parse attr_writer :values
=end
	def values=(values)
		check_dice values
		@values = values
	end

	private 
	def new_dice; return (1..6).to_a.sample; end # @return [Fixnum] a random number between 1 and 6, inclusive
=begin
@param dice [Array<Fixnum>]
@return [void]
@raise [ArgumentError] if dice does not meet expectations
=end
	def check_dice(dice)
		raise(ArgumentError, "Array must have 5 Integers that are between 1 and 6") unless dice.length == 5 && dice.all? {|val| (val.is_a? Fixnum) && (val.between? 1,6)}
	end
end
