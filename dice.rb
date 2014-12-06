# Class for the 5 dice in the game

class Dice

	def initialize()
		@five_dice = 5.times.map{ 1 + rand(5)}
	end

	def roll_all()
		initialize()
	end

	# Rolls a single dice
	def roll(i)
		if i >= 0 && i<=5
			@five_dice[i-1] = 1 + rand(5)
		end
	end


	def display()
		@five_dice.each do |i|
			puts i
		end
		puts "\n"
	end

	# Orders dice in ascending order
	def sort()
		@five_dice = @five_dice.sort
	end

end

# testing
d = Dice.new()

(0..5).each do
	d.roll_all
	d.display()
	d.sort()
	d.display()
end


