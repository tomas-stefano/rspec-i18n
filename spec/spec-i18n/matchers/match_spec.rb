require 'spec_helper'

describe "should match(expected)" do
  before(:each) do
    @expected_matcher = {'matchers' => { 'match' => 'corresponder|corresponde'} }
    stub_language!("pt", @expected_matcher)
    Spec::Matchers.register_all_matchers
  end
  
  it "should translated the include matcher" do
    [:corresponder, :corresponde].each do |translated_matcher|
      methods.to_symbols.should include(translated_matcher)
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