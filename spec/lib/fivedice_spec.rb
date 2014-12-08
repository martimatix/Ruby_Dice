require "spec_helper"
require "fivedice"
RSpec.describe FiveDice do
 	describe "#new" do
  		describe "dice" do
    			subject {FiveDice.new.dice}
    			its(:sample) {is_expected.to be_an_instance_of Dice}
		end
	subject {FiveDice.new}
    	it {is_expected.to be_kind_of Dice}
	it {is_expected.to be_an_instance_of FiveDice}
 	end
end
