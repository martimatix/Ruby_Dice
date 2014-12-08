class Dice # Class for a die in the game
	attr_reader :num
	Faces = [1, 2, 3, 4, 5, 6] # Every face on the dice
	def initialize; @num = Faces.sample; end
	def roll; @num = Faces.sample; end # Rolls the dice
	alias to_s num
	alias inspect num
end

