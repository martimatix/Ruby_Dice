require "spec_helper"
require "dice"
RSpec.describe Dice do
	describe "#new" do
		subject {Dice.new}
		it {is_expected.to respond_to(:roll)}
	end
end
RSpec.describe Dice::Faces do
	it {is_expected.to eq (1..6).to_a}
end
