require 'spec_helper'

describe "should be_predicate" do
  
  before(:each) do
    portuguese_language({"matchers" => {"be" => "ser"}, "true" => "verdadeiro"})
    Spec::Matchers.register_all_matchers
  end
  
  context "be predicate" do

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
  end
  
  context "be nil, true and false" do
    before(:each) do
      @pt = Parser::NaturalLanguage.get("pt")
      @es = Parser::NaturalLanguage.get("es")
    end
    
    context "be true" do
      
      before(:each) do
        include Spec::Matchers
        @pt_keywords = { "matchers" => {'be' => 'ser',"true" => "verdadeiro"}}
        @pt.stub!(:keywords).and_return(@pt_keywords)
        @es_keywords = { "matchers" => {'be' => 'ser',"true" => "verdadero" }}
        @es.stub!(:keywords).and_return(@es_keywords)
      end
    
      it "should translate true keyword for pt" do
        SpecI18n.stub!(:natural_language).and_return(@pt)
        matcher_be = "#{@pt_keywords['matchers']['be']}"
        matcher_true = "#{@pt_keywords['matchers']['true']}"
        expected = "#{matcher_be}_#{matcher_true}"
        Be.matcher_be_true.should == [expected.to_sym ]
      end
    
      it "should translate true keyword for es" do
        SpecI18n.stub!(:natural_language).and_return(@es) 
        matcher_be = "#{@es_keywords['matchers']['be']}"
        matcher_true = "#{@es_keywords['matchers']['true']}"
        expected = "#{matcher_be}_#{matcher_true}"
        Be.matcher_be_true.should == [expected.to_sym]
      end
      
      it "should translate true keyword in | char" do
        language = { 'matchers' => {'be' => 'ser', 'true' => 'verdadeiro|verdade'}}
        SpecI18n.stub!(:natural_language).and_return(@es)
        @es.stub!(:keywords).and_return(language)
        expected = [:ser_verdadeiro, :ser_verdade]
        Be.matcher_be_true.should == expected
      end
      
      it "should pass when actual equal?(true)" do
        [@pt, @es].each do |language|
          SpecI18n.stub!(:natural_language).and_return(language)
          Be.translate_be_true
          matcher_be_true.each do |word_be_true|
              eval <<-BE_TRUE
                true.should #{word_be_true}
                1.should #{word_be_true}
              BE_TRUE
          end
        end
      end
      
    end
    
  end
  
  context "convert the be word" do
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
  
end