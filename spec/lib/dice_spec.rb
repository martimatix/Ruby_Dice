require "spec_helper"
require "dice"
RSpec.describe Dice do
 	describe "#new" do
  		describe "dice" do
    			subject {Dice.new.dice}
    			it {is_expected.to be_an_instance_of Array}
		end
	subject {Dice.new}
	it {is_expected.to be_an_instance_of Dice}
 	end
end
