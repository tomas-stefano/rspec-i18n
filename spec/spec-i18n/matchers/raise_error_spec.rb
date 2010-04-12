require 'spec_helper'

describe "should raise_error" do
  
  before(:each) do
    @expected_matcher = {'matchers' => {'raise_error' => 'mostrar_erro|mostrar_excessao'}}
    stub_language!("pt", @expected_matcher)
    Spec::Matchers.register_all_matchers
  end
  
  it 'should register the methods for the value equal matcher' do
    [:mostrar_erro, :mostrar_excessao].each do |translated_matcher|
      methods.to_symbols.should include(translated_matcher)
    end
  end
  
  it "should pass if anything is raised" do
    lambda {raise}.should mostrar_erro
  end
  
  it "should fail if nothing is raised" do
    lambda {
      lambda {}.should mostrar_erro
    }.should mostrar_erro
  end
end