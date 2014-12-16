require "spec_helper"
require "scoresheet"
describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		it {is_expected.to respond_to(:chance, :filled?, :large_straight, :small_straight, :full_house, :yahtzee, :four_of_a_kind, :three_of_a_kind, :enter_score, :dice)}
		its(:large_straight) {is_expected.to eq(40) | be_zero}
		its(:chance) {is_expected.to be >= 5}
		its(:dice) {is_expected.to be_instance_of Dice}
		its(:sheet) {is_expected.to be_instance_of Hash}
		its(:yahtzee) {is_expected.to be_zero | eq(50)}
		its(:small_straight) {is_expected.to eq(30) | be_zero}
		describe "ones" do
			context "when @dice.values == [1, 1, 2, 2, 2]" do
				subject {ScoreSheet.new([1,1,2,2,2]).ones}
				it {is_expected.to eq 2}
			end
		end
		describe "full_house" do
			context "when @dice.values == [1, 1, 2, 2, 2]" do
				subject {ScoreSheet.new([1,1,2,2,2]).full_house}
				it {is_expected.to eq 25}
			end
			context "when @dice.values == [2, 2, 2, 2, 2]" do
				subject {ScoreSheet.new(Array.new(5) {2}).full_house}
				it {is_expected.to eq 25}
			end
			context "when @dice.values == [1, 1, 2, 2, 5]" do
				subject {ScoreSheet.new([1,1,2,2,5]).full_house}
				it {is_expected.to be_zero}
			end
		end
		describe "three_of_a_kind" do
			tok = proc do |array|
				s = ScoreSheet.new array
				s.three_of_a_kind
			end
			context "when @dice.values == [1, 2, 2, 2, 2]" do
				subject {tok.call [1, 2, 2, 2, 2]}
				it {is_expected.to eq 9}
			end
			context "when @dice.values == [1, 2, 2, 2, 5]" do
				subject {tok.call [1,2,2,2,5]}
				it {is_expected.to eq 12}
			end
			context "when @dice.values == [1, 2, 2, 3, 4]" do
				subject {tok.call [1, 2, 2, 3, 4]}
				it {is_expected.to be_zero}
			end
		end
		describe "four_of_a_kind" do
			fok = proc do |array|
				s = ScoreSheet.new array
				s.four_of_a_kind
			end
			context "when @dice.values == [1, 2, 2, 2, 2]" do
				subject {fok.call [1,2,2,2,2]}
				it {is_expected.to eq 9}
			end
			context "when @dice.values == [1, 1, 2, 2, 2]" do
				subject {fok.call [1, 1, 2, 2, 2]}
				it {is_expected.to be_zero}
			end
		end
		describe "enter_score" do
			enter_score = proc do |array, field|
				s = ScoreSheet.new array
				s.enter_score field
				s.sheet[field]
				
			end
			context "@dice.values == [1, 1, 2, 2, 2]" do
				subject {enter_score.call [1, 1, 2, 2, 2], :full_house}
				it {is_expected.to eq [25, true]}
			end
		end
		i = 1
		for score in ScoreSheet::UpperScores
			its(score) {is_expected.to be_instance_of Fixnum}
			i += 1
		end
		describe "filled?" do
			context "when not filled" do
				subject {ScoreSheet.new}
				it {is_expected.to_not be_filled}
			end
			context "when filled" do
				subject do
					s = ScoreSheet.new
					s.sheet.each {|key, val| s.sheet[key][1] = true}
					s
				end
				it {is_expected.to be_filled}
			end
		end
		describe "raw_upper" do
			context "when @dice.dice == [1, 1, 2, 2, 2] and :ones, :twos is entered into the sheet" do
				subject do
					s = ScoreSheet.new([1,1,2,2,2])
					s.enter_score(:ones)
					s.enter_score(:twos)
					s.raw_upper
				end
				it {is_expected.to eq 8}
			end
		end
	end
end



