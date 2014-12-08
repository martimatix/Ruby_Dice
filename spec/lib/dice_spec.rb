require "spec_helper"
require "dice"
describe Dice do
	describe "#new" do
		subject {Dice.new}
		it {is_expected.to respond_to(:roll)}
	end
end
	
