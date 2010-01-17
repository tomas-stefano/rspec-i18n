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
    
    
    pending('verify rspec 1.3')
    
    atual = stub("atual", :feliz? => false)
    lambda {
      atual.should be_feliz
    }.should fail_with("expected feliz? to return true, got false")
  end
  
  it "should fail when actual returns false for :predicate?" do
    
    pending('verify rspec 1.3')
    
    atual = stub("atual", :feliz? => nil)
    lambda {
      atual.should be_feliz
    }.should fail_with("expected feliz? to return true, got nil")
  end
  
  it 'should be true for the new :predicate' do
    atual = true
    pending("SHOULD translate true, false, nil, empty for the default MATCHERS")
    atual.should ser_true
  end
  
  it 'should convert be word to english with two parameters' do
    be_to_english(:ser_feliz, 'ser|estar').should == :be_feliz
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