require "spec_helper"
require "fivedice"
RSpec.describe FiveDice do
  describe "#new" do
    subject {FiveDice.new}
    its(:sample) {is_expected.to be_an_instance_of Dice}
    it {is_expected.to be_kind_of Dice}
  end
end
