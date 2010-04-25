require "spec_helper"

describe SpecI18n do
  
  before(:each) do
    @configuration = Spec::Runner.configuration
    @configuration.should_receive(:warning_messages_for_incomplete_languages!).and_return(true)
    @configuration.should_receive(:load_language).and_return(true)
  end
    
  it "should assign the spec language constant" do
    @configuration.spec_language('pt')
    spec_language.should == 'pt'
  end
  
  it 'should assign the spec language' do
    @configuration.spec_language('es')
    spec_language.should == 'es'
  end
  
  it 'should assign the spec_language' do
    @configuration.spec_language('en-au')
    spec_language.should == 'en-au'
  end
  
  it "should assign the spec language - available for all modules" do
    @configuration.spec_language('ko')
    spec_language.should == 'ko'
  end
  
  it "should assign the natural language" do
    @configuration.spec_language('pt')
    natural_language.keywords.should == Parser::NaturalLanguage.new(spec_language).keywords
  end
  
end