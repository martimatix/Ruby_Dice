class Dice # Class for the 5 dice in the game
	def initialize; @five_dice = 5.times.map{ 1 + rand(5)}; end
	def roll_all; new; end
	def roll(i) # Rolls a single dice
		@five_dice[i-1] = 1 + rand(5) if i >= 0 && i<=5
	end
	def display # Display instance variable five_dice
		@five_dice.each {|i| puts i}
		puts "\n"
	end

	
	def sort # Orders dice in ascending order
		@five_dice = @five_dice.sort
	end

end

# testing
d = Dice.new

(0..5).each do
	d.roll_all
	d.display
	d.sort
	d.display
end


