require "player"

RSpec.describe Player do
  describe "#new" do
    it {is_expected.to respond_to(:take_turn, :score)}
  end
end
