require "spec_helper"

describe SpecI18n do
  
  before(:each) do
    include SpecI18n
  end
  
  it "should assign the spec language constant" do
    languages = ["pt", "es"]
    languages.each do |language|
      Spec::Runner.configuration.spec_language(language)
      spec_language.should == language
    end
  end
end