require "spec_helper"
require "double_digit"
RSpec.describe "double_digit()" do
  subject {double_digit rand(100)} 
  it "should have an alias of dd()" do; expect(double_digit(1)).to eq dd(1); end
  it {is_expected.to be_an_instance_of String}
end
