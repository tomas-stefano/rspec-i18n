require 'spec_helper'

describe Object, "#should and #should_not" do
  
  before(:each) do
    @keywords = { 'should' => 'deve|deveria', 'should_not' => 'nao_deve|nao_deveria'}
    stub_language!('pt', @keywords)
    Kernel.register_expectations_keywords
  end
  
  context 'when #should' do
    
    it "should translate the #should method" do
      [:deve, :deveria].each do |expetation_method|
        Kernel.methods.to_sym.should include(expetation_method)
      end
    end
    
    it "should use the #should method" do
      1.deve == 1
    end
    
  end
  
  context 'when #should_not' do
    
    it "should translate the #should_not method" do
      [:nao_deve, :nao_deveria].each do |expectation_method|
        Kernel.methods.to_sym.should include(expectation_method)
      end
    end
    
    it "should use the #should_not method" do
      2.should_not == 1
    end
    
  end
  
end
