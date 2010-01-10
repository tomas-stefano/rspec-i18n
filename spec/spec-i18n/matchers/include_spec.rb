require 'spec_helper'

describe "should include(expected)" do
  before(:each) do
    @expected_matcher = {'matchers' => { 'include' => 'incluir'} }
    portuguese_language(@expected_matcher)
    Spec::Matchers.register_include_matcher
  end
  
  it "should translated the include matcher" do
    values = @expected_matcher['matchers']['include'].split('|')
    
    values.each do |value_method|
      Object.instance_methods.should be_include(value_method)
    end
    
  end
  
  it "should pass if target includes expected" do
    [1,2,3].should incluir(3)
    "abc".should incluir("a")
  end
  
  it 'should pass if target is a Hash and has the expected as a key' do
    {:key => 'value'}.should incluir(:key)
  end
  
  it "should fail if target does not include expected" do
    lambda {
      [1,2,3].should incluir(4)
    }.should raise_error
  end
  
end