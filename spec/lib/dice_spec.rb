require "rspec"
require "dice.rb"
describe Dice do
	describe "#new" do
		subject {Dice.new}
		it {is_expected.to respond_to(:display, :sort, :roll, :roll_all)}
	end
end
	