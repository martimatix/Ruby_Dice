require "dice"

RSpec.describe Dice do
 	describe "#new" do
 		subject {Dice.new}
 		it {is_expected.to be_an_instance_of Dice}
 		it {is_expected.to respond_to :to_s, :values, :values=, :roll, :roll_all}
  		describe "values" do
    			subject {Dice.new.values}
    			it {is_expected.to be_an_instance_of Array}
			its(:length) {is_expected.to eq 5}
			its(:sample) {is_expected.to eq 1..6}
		end
		describe "values=" do
			context "when [1, 2, 3, 4, 5]" do
				subject do
					test_dice = Dice.new [1, 2, 3, 4, 5]
					test_dice.values
				end
				let(:test_val) {(1..5).to_a}
				it {is_expected.to eq test_val}
			end
			context "when #{ %w(1 2 3 4 5 6) }" do
				it "should raise ArgumentError, \"Array must have 5 Integers that are between 1 and 6\"" do
					expect {Dice.new %w(1 2 3 4 5 6) }.to raise_error(ArgumentError, "Array must have 5 Integers that are between 1 and 6")
				end
			end
		end
	end
end
