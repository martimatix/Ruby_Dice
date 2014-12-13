require "spec_helper"
require "dice"
RSpec.describe Dice do
 	describe "#new" do
 		subject {Dice.new}
 		it {is_expected.to be_an_instance_of Dice}
  		describe "dice" do
    			subject {Dice.new.dice}
    			it {is_expected.to be_an_instance_of Array}
		end
 	end
 	it "sets the values of the dice" do
 		test_dice = Dice.new
 		test_val = [1,2,3,4,5]
 		test_dice.set_dice(test_val)
 		expect(test_dice.dice).to eq(test_val)
 	end
end
