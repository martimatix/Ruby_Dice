require "spec_helper"
describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		it {is_expected.to respond_to(:chance, :filled?, :large_straight, :small_straight, :full_house, :yahtzee, :four_of_a_kind, :three_of_a_kind, :enter_score, :dice)}
		its(:full_house) {is_expected.to eq(25) | be_zero}
		its(:large_straight) {is_expected.to eq(40) | be_zero}
		its(:chance) {is_expected.to be >= 5}
		its(:dice) {is_expected.to be_instance_of Dice}
		its(:sheet) {is_expected.to be_instance_of Hash}
		its(:filled?) {is_expected.to be false}
		its(:yahtzee) {is_expected.to be_zero | eq(50)}
		its(:small_straight) {is_expected.to eq(30) | be_zero}
		i = 1
		for score in ScoreSheet::UpperScores
			its(score) {is_expected.to be_instance_of Fixnum}
			i += 1
		end
	end
	describe "::UpperScores" do
		subject {ScoreSheet::UpperScores}
		for field in ScoreSheet::UpperScores
			it {is_expected.to be_include field}
		end
	end
end
