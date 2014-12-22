require "dice"
RSpec.describe Dice do
 	describe "#new" do
 		subject {Dice.new}
 		it {is_expected.to be_an_instance_of Dice}
  		describe "values" do
    			subject {Dice.new.values}
    			it {is_expected.to be_an_instance_of Array}
		end
		describe "values=" do
			context "when legal" do
				subject do
					test_dice = Dice.new [1, 2, 3, 4, 5]
					test_dice.values
				end
				let(:test_val) {(1..5).to_a}
				it {is_expected.to eq test_val}
			end
			context "when illegal" do
				it "should raise ArgumentError, \"Array must have 5 Integers that are between 1 and 6\"" do
					expect {Dice.new %w(1 2 3 4 5 6) }.to raise_error(ArgumentError, "Array must have 5 Integers that are between 1 and 6")
				end
			end
		end
	end
end
