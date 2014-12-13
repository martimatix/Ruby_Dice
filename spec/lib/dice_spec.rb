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
		describe "dice=" do
			subject do
				test_dice = Dice.new
				test_dice.dice = [1, 2, 3, 4, 5]
				test_dice.dice
			end
			let(:test_val) {(1..5).to_a}
			it {is_expected.to eq test_val}
		end
	end
end
