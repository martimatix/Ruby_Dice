require "player"

RSpec.describe Player do
  describe "#new" do
    subject {Player.new}
    it {is_expected.to respond_to(:take_turn, :score)}
  end
end
