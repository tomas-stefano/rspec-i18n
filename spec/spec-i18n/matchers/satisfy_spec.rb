require 'spec_helper'

describe "should satisfy { block }" do
  
  before(:each) do
    @keywords = { 'matchers' => { 'satisfy' => 'satisfazer|satisfaz'} }
    stub_language!("pt", @keywords)
    Spec::Matchers.register_all_matchers
  end
  
  it 'should trasnlate the satisfy matcher' do
    [:satisfazer, :satisfazer].each do |translated_matcher|
      methods.to_symbols.should include(translated_matcher)
    end
  end
  
  it "should pass if block returns true" do
    true.should satisfazer { |val| val }
    true.should satisfazer do |val|
      val
    end
  end

  it "should fail if block returns false" do
    false.should_not satisfazer { |val| val }
  end
end