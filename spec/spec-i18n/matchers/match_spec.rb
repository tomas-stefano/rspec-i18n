require 'spec_helper'

describe "should match(expected)" do
  before(:each) do
    @expected_matcher = {'matchers' => { 'match' => 'corresponder'} }
    portuguese_language(@expected_matcher)
    Spec::Matchers.register_all_matchers
  end
  
  it "should translated the include matcher" do
    values = @expected_matcher['matchers']['match'].split('|')
    values.each do |value_method|
      Object.instance_methods.should be_include(value_method)
    end
  end
  
  it "should pass when target (String) matches expected (Regexp)" do
    "string".should corresponder(/tri/)
  end

  it "should pass when target (String) matches expected (String)" do
    "string".should corresponder("tri")
  end

  it "should fail when target (String) does not match expected (Regexp)" do
    lambda {
      "string".should corresponder(/rings/)
    }.should raise_error
  end

  it "should fail when target (String) does not match expected (String)" do
    lambda {
      "string".should corresponder("rings")
    }.should raise_error
  end
end