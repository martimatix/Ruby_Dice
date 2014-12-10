require "spec_helper"
require "scoresheet"
describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		it {is_expected.to respond_to(:chance, :large_straight, :small_straight, :full_house, :yahtzee, :four_of_a_kind, :three_of_a_kind, :enter_score, :dice)}
		its(:full_house) {is_expected.to eq(25) | be_zero}
		its(:large_straight) {is_expected.to eq(40) | be_zero}
		its(:chance) {is_expected.to be >= 5}
		its(:dice) {is_expected.to be_instance_of Dice}
		its(:sheet) {is_expected.to be_instance_of Hash}
		its(:filled) {is_expected.to be false}
		its(:yahtzee) {is_expected.to be_zero | eq(50)}
		its(:small_straight) {is_expected.to eq(30) | be_zero}
		its(:ones) {is_expected.to satisfy {|value| (value % 1).zero?}}
		its(:twos) {is_expected.to satisfy {|value| (value % 2).zero?}}
		its(:threes) {is_expected.to satisfy {|value| (value % 3}.zero?}}
		its(:fours) {is_expected.to satisfy {|v| (v % 3).zero?}}
		its(:fives) {is_expected.to satisfy {|v| (v % 3).zero?}}
	end
	describe "::UpperScores"
end
