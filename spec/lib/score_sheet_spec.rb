require "rspec"
require "score_sheet.rb"
describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		it {is_expected.to respond_to(:straight, :of_a_kind, :mode, :freq, :chance, :large_straight, :small_straight, :full_house, :yahtzee, :four_of_a_kind, :three_of_a_kind, :singe_face, :enter_score)}