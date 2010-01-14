require 'spec_helper'

describe "should be_predicate" do
  
  before(:each) do
    portuguese_language({"matchers" => {"be" => "ser"}})
    Spec::Matchers.register_all_matchers
  end
  
  it "should pass with be language translated" do
    atual = stub("atual", :feliz? => true)
    atual.should ser_feliz
  end
  
  it "should fail when actual returns false for :predicate?" do
    atual = stub("atual", :feliz? => false)
    atual.should_not ser_feliz
  end
  
  it 'should be true for the new :predicate' do
    atual = true
    pending("SHOULD translate true, false, nil, empty for the default MATCHERS")
    atual.should ser_true
  end
  
  it "should raise error for the not expected :predicate?" do
    atual = stub("atual", :feliz? => false)
    lambda { atual.should ser_feliz }.should raise_error
  end
  
  it "should convert be word to english" do
    be_to_english(:ser_feliz, :ser).should == :be_feliz
  end
  
  it "should keep the same word in english(don't break the rspec defaults)" do
    be_to_english(:be_include, :be).should == :be_include
  end
  
  it "should keep the same word for the non existing word" do
    be_to_english(:be_include, :ser).should == :be_include
  end
  
  it "should keep the same word for the nil be word" do
    be_to_english(:be_include, nil).should == :be_include
  end
end