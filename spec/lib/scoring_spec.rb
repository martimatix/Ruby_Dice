require "scoring"

RSpec.describe Scoring do
	include Scoring
	for score in Scoring::UpperScores
		its(score, Dice.new.values) {is_expected.to be_instance_of Fixnum}
		i += 1
	end
	describe "large_straight" do
		context "when [1, 2, 3, 4, 5]" do
			subject {large_straight [1, 2, 3, 4, 5]}
			it {is_expected.to eq 40}
		end
		context "when [1, 2, 4, 5, 6]" do
			subject {large_straight [1, 2, 4, 5, 6]}
			it {is_expected.to be_zero}
		end
	end
	describe "chance" do
		subject {chance Dice.new.values}
		it {is_expected.to be_instance_of Fixnum}
		it {is_expected.to_not be_zero}
		context "when [1, 2, 3, 4, 5]" do
			subject {chance [1,2,3,4,5]}
			it {is_expected.to eq 15}
		end
		context "when [1, 2, 2, 5, 6]" do
			subject {chance [1, 2, 2, 5, 6]}
			it {is_expected.to eq 16}
		end
	end
	describe "small_straight" do
		subject {small_straight Dice.new.values}
		it {is_expected.to be_an_instance_of Fixnum}
		context "when [1, 2, 3, 4, 6]" do
			subject {small_straight [1, 2, 3, 4, 6]}
			it {is_expected.to eq 30}
		end
		context "when [1, 2, 2, 5, 6]" do
			subject {small_straight [1, 2, 2, 5, 6]}
			it {is_expected.to be_zero}
		end
	end
	describe "ones" do
		context "when [1, 1, 2, 2, 2]" do
			subject {ones [1, 1, 2, 2, 2]}
			it {is_expected.to eq 2}
		end
	end
	describe "three_of_a_kind" do
		context "when [1, 2, 2, 2, 2]" do
			subject {three_of_a_kind [1, 2, 2, 2, 2]}
			it {is_expected.to eq 9}
		end
		context "when [1, 2, 2, 2, 5]" do
			subject {three_of_a_kind [1,2,2,2,5]}
			it {is_expected.to eq 12}
		end
		context "when [1, 2, 2, 3, 4]" do
			subject {three_of_a_kind [1, 2, 2, 3, 4]}
			it {is_expected.to be_zero}
		end
	end
	describe "full_house" do
		context "when [1, 1, 2, 2, 2]" do
			subject {full_house [1,1,2,2,2]}
			it {is_expected.to eq 25}
		end
		context "when [2, 2, 2, 2, 2]" do
			subject {full_house Array.new(5) {2}}
			it {is_expected.to eq 25}
		end
		context "when [1, 1, 2, 2, 5]" do
			subject {full_house [1,1,2,2,5]}
			it {is_expected.to be_zero}
		end
	end
	describe "four_of_a_kind" do
		context "when [1, 2, 2, 2, 2]" do
			subject {four_of_a_kind [1,2,2,2,2]}
			it {is_expected.to eq 9}
		end
		context "when [1, 1, 2, 2, 2]" do
			subject {four_of_a_kind [1, 1, 2, 2, 2]}
			it {is_expected.to be_zero}
		end
	end
end
