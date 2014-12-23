require "scoresheet"

describe ScoreSheet do
	describe "#new" do
		subject {ScoreSheet.new}
		its(:dice) {is_expected.to be_instance_of Dice}
		its(:sheet) {is_expected.to be_instance_of Hash}
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
		describe "yahtzee" do
			yz = proc {|array| ScoreSheet.new(array).yahtzee}
			context "when @dice.values == [1, 2, 2, 2, 2]" do
				subject {yz.call [1,2,2,2,2]}
				it {is_expected.to be_zero}
			end
			context "when @dice.values == [2, 2, 2, 2, 2]" do
				subject {yz.call [2, 2, 2, 2, 2]}
				it {is_expected.to eq 50}
				context "Additional Yahtzee" do
					subject do
						s = ScoreSheet.new([2,2,2,2,2])
						s.enter_score(:yahtzee)
						s.enter_score(:yahtzee)
						s.sheet[:yahtzee][0]
					end
					it {is_expected.to eq 150}
				end
				context "Another Additional Yahtzee (Three Yahtzees)" do
					subject do
			 			s = ScoreSheet.new [2,2,2,2,2]
			 			3.times {s.enter_score :yahtzee}
			 			s.sheet[:yahtzee].first
			 		end
			 		it {is_expected.to eq 350}
				end
			end
		end
		i = 1
		for score in Scoring::UpperScores
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
			context "when @dice.values == [1, 1, 2, 2, 2] && :ones, :twos is entered into the sheet" do
				subject do
					s = ScoreSheet.new([1,1,2,2,2])
					s.enter_score :ones
					s.enter_score :twos
					s.raw_upper
				end
				it {is_expected.to eq 8}
			end
		end
	end
end



