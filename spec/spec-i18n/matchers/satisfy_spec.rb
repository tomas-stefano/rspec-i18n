require 'spec_helper'

describe "should satisfy { block }" do
  
  before(:each) do
    @expected_matcher = { 'matchers' => { 'satisfy' => 'satisfazer'} }
    portuguese_language(@expected_matcher)
    Spec::Matchers.register_all_matchers
  end
  
  it 'should trasnlate the satisfy matcher' do
    values = @expected_matcher['matchers']['satisfy'].split('|')
    values.each do |value_method|
      methods_list = Object.instance_methods.all_to_symbols
      methods_list.should be_include(value_method.to_sym)
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