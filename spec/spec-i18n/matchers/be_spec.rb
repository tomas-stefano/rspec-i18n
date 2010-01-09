require 'spec_helper'

describe "should be_predicate" do
  
  before(:each) do
    include SpecI18n
    @pt = Parser::NaturalLanguage.get("pt")
    Spec::Runner.configuration.spec_language("pt")
  end
  
  it "should pass with language translated" do
    SpecI18n.should_receive(:natural_language).and_return(@pt)
    expected = {"matchers" => {"be" => "ser|sera"}}
    predicade = @pt.should_receive(:keywords).and_return(expected)
    
    Spec::Matchers::Be.register_be_matcher
    
    pending("WAITING FOR THE BE TRANSLATED IN METHOD MISSING")
    
    actual = stub("actual", :happy? => true)
    actual.should ser_happy
  end
end