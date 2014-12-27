require "player"

RSpec.describe Player do
  describe "#new" do
    subject {Player.new}
    it {is_expected.to respond_to(:take_turn, :display_dice, :user_input)}
    its(:score) {is_expected.to be_instance_of ScoreSheet}
  end
end
