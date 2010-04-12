require 'spec_helper'

describe 'have, have_exactly, have_at_least and have_at_most matcher' do
  
  before(:each) do
    matchers = {'have' => 'ter', 'have_at_least' => 'ter_no_minimo', 
                'have_exactly' => 'ter_exatamente', 
                'have_at_most' => 'ter_no_maximo'}
    @expected_matcher = {'matchers' => matchers}
    stub_language!("pt", @expected_matcher)
    Spec::Matchers.register_all_matchers
  end
  
  describe 'should have(n).items' do
  
    it 'should pass if target has a collection of items with n members' do
      [1, 2, 3].should ter(3).items
    end
    
    it "should pass if target has a collection of items with < n members" do
      [1, 2, 3].should_not ter(4).items
    end
  
  end
  
  describe 'should have_exactly(n).items' do
    
    it "should pass if target has a collection of items with n members" do
      [1,2,3].should ter_exatamente(3).items
    end
    
    it 'should fail if target has a collection of items with < n members' do
      [1,2,3].should_not ter_exatamente(4).items
    end
    
  end
  
  describe "should have_at_least(n).items" do

    it "should pass if target has a collection of items with n members" do
      [1, 2, 3].should ter_no_minimo(3).items
    end
    
    it "should fail if target has a collection of items with < n members" do
      [1, 2, 3].should_not ter_no_minimo(4).items
    end
    
  end
  
  describe "should have_at_most(n).items" do

    it "should pass if target has a collection of items with n members" do
      [1, 2, 3].should ter_no_maximo(3).items
    end

    it "should fail if target has a collection of items with > n members" do
      [1, 2, 3].should_not ter_no_maximo(2).items
    end
  end
  
end