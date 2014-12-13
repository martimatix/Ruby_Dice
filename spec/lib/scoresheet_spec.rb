require "spec_helper"
describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		it {is_expected.to respond_to(:chance, :filled?, :large_straight, :small_straight, :full_house, :yahtzee, :four_of_a_kind, :three_of_a_kind, :enter_score, :dice)}
		its(:large_straight) {is_expected.to eq(40) | be_zero}
		its(:chance) {is_expected.to be >= 5}
		its(:dice) {is_expected.to be_instance_of Dice}
		its(:sheet) {is_expected.to be_instance_of Hash}
		its(:filled?) {is_expected.to be false}
		its(:yahtzee) {is_expected.to be_zero | eq(50)}
		its(:small_straight) {is_expected.to eq(30) | be_zero}
		describe "ones" do
			single = proc do |array|
				s = ScoreSheet.new
				s.dice.set_dice array
				s.ones
			end
			context "when @dice.dice == [1, 1, 2, 2, 2]" do
				subject {single.call [1,1,2,2,2]}
				it {is_expected.to eq 2}
			end
		end
		describe "ones" do
			single = proc do |array|
				s = ScoreSheet.new
				s.dice.set_dice array
				s.ones
			end
			context "when @dice.dice == [1, 1, 2, 2, 2]" do
				subject {single.call [1,1,2,2,2]}
				it {is_expected.to eq 2}
			end
		end
		describe "full_house" do
			fh = proc do |array|
				s = ScoreSheet.new
				s.dice.set_dice array
				s.full_house
			end
			context "when @dice.dice == [1, 1, 2, 2, 2]" do
				subject {fh.call [1,1,2,2,2]}
				it {is_expected.to eq 25}
			end
			context "when @dice.dice == [2, 2, 2, 2, 2]" do
				subject {fh.call Array.new(5) {2}}
				it {is_expected.to eq 25}
			end
			context "when @dice.dice == [1, 1, 2, 2, 5]" do
				subject {fh.call [1,1,2,2,5]}
				it {is_expected.to be_zero}
			end
		end
		describe "three_of_a_kind" do
			tok = proc do |array|
				s = ScoreSheet.new
				s.dice.set_dice array
				s.three_of_a_kind
			end
			context "when @dice.dice == [1, 2, 2, 2, 2]" do
				subject {tok.call [1, 2, 2, 2, 2]}
				it {is_expected.to eq 9}
			end
			context "when @dice.dice == [1, 2, 2, 2, 5]" do
				subject {tok.call [1,2,2,2,5]}
				it {is_expected.to eq 12}
			end
			context "when @dice.dice == [1, 2, 2, 3, 4]" do
				subject {tok.call [1, 2, 2, 3, 4]}
				it {is_expected.to be_zero}
			end
		end
		describe "four_of_a_kind" do
			fok = proc do |array|
				s = ScoreSheet.new
				s.dice.set_dice array
				s.four_of_a_kind
			end
			context "when @dice.dice == [1, 2, 2, 2, 2]" do
				subject {fok.call [1,2,2,2,2]}
				it {is_expected.to eq 9}
			end
			context "when @dice.dice == [1, 1, 2, 2, 2]" do
				subject {fok.call [1, 1, 2, 2, 2]}
				it {is_expected.to be_zero}
			end
		end
		i = 1
		for score in ScoreSheet::UpperScores
			its(score) {is_expected.to be_instance_of Fixnum}
			i += 1
		end
	end
end



