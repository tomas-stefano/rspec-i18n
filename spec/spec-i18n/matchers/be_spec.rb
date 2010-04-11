require 'spec_helper'

describe "should be_predicate" do
  
  context "be predicate" do
    
    before(:each) do
      portuguese_language({"matchers" => {"be" => "ser",  "true_word" => "verdadeiro"}})
      Spec::Matchers.translate_be_matcher
    end

    it "should pass with be language translated" do
      atual = stub("atual", :feliz? => true)
      atual.should ser_feliz
    end
  
    it "should fail when actual returns false for :predicate?" do
      atual = stub("atual", :feliz? => false)
      lambda {
        atual.should ser_feliz
      }.should fail_with("expected feliz? to return true, got false")
    end
  
    it "should fail when actual returns false for :predicate?" do
      atual = stub("atual", :feliz? => nil)
      lambda {
        atual.should ser_feliz
      }.should fail_with("expected feliz? to return true, got nil")
    end
  end
  
  context "be words" do
    before(:each) do
      @pt = Parser::NaturalLanguage.get("pt")
      @es = Parser::NaturalLanguage.get("es")
    end
    
    describe "when matcher be some word(true, false,nil or empty)" do
            
      before(:each) do
        @pt_keywords = { "matchers" => {'be' => 'ser|estar', 
          "true_word" => "verdadeiro|verdade", 
          "false_word" => "falso|muito_falso",
          "empty_word" => "vazio|sem_elemento",
          "nil_word" => "nulo|null" }}
        stub_keywords!(@pt, @pt_keywords)
        mock_natural_language(@pt)
      end
      
      it "should translate true word for languages" do
        expected = [:ser_verdadeiro, :ser_verdade, :estar_verdadeiro, :estar_verdade]
        Spec::Matchers.matcher_be_some(:true => true).should == expected
      end
      
      it "should translate false word for languages" do
        expected = [:ser_falso, :ser_muito_falso, :estar_falso, :estar_muito_falso]
        Spec::Matchers.matcher_be_some(:false => true).should == expected
      end
      
      it "should translate false word for languages" do
        expected = [:ser_vazio, :ser_sem_elemento, :estar_vazio, :estar_sem_elemento]
        Spec::Matchers.matcher_be_some(:empty => true).should == expected
      end
      
      it "should translate nil word for languages" do
        expected = [:ser_nulo, :ser_null, :estar_nulo, :estar_null]
        Spec::Matchers.matcher_be_some(:nil => true).should == expected
      end
      
    end
    
    context "be true predicate" do
      
      before(:each) do
        @pt_keywords = { "matchers" => {'be' => 'ser', "true_word" => "verdadeiro|verdade" }}
        stub_keywords!(@pt, @pt_keywords)
        mock_natural_language(@pt)
        Spec::Matchers.translate_be_true
      end
               
      it "should pass when actual equal?(true) for language" do
        true.should ser_verdadeiro
        true.should ser_verdade
      end
      
      it "should pass when actual is 1" do
        1.should ser_verdadeiro
        1.should ser_verdade
      end
      
    end

    context "be false predicate" do
      
      before(:each) do
        @pt_keywords = { "matchers" => {'be' => 'ser', "false_word" => "falso|muito_falso" }}
        stub_keywords!(@pt, @pt_keywords)
        mock_natural_language(@pt)
        Spec::Matchers.translate_be_false
      end
      
      it "should pass when actual equal?(false) for language" do
        false.should ser_falso
        false.should ser_muito_falso 
      end
      
      it "should pass when actual equal?(nil) for language" do
        nil.should ser_falso
        nil.should ser_muito_falso
      end
      
    end
    
    context "be nil predicate" do
      
      before(:each) do
        @pt_keywords = { "matchers" => {'be' => 'ser', "nil_word" => "nulo|null" }}
        stub_keywords!(@pt, @pt_keywords)
        mock_natural_language(@pt)
        Spec::Matchers.translate_be_nil
      end
        
      it "should pass when actual is nil" do
        nil.should ser_nulo
        nil.should ser_null
      end
      
      it "should pass when not be nil and actual is not nil" do
        :not_nil.should_not ser_nulo
        :not_nil.should_not ser_null
      end
      
    end
    
    context "be empty predicate" do
      
      before(:each) do
        @pt_keywords = { "matchers" => {'be' => 'ser', "empty_word" => "vazio|sem_elemento" }}
        stub_keywords!(@pt, @pt_keywords)
        mock_natural_language(@pt)
        Spec::Matchers.translate_be_empty
      end
      
      it "should pass when actual is empty" do
        [].should ser_vazio
        [].should ser_sem_elemento
      end
      
      it "should pass when not is empty and actual is not empty" do
        [:not_empty].should_not ser_vazio
        [:not_empty].should_not ser_sem_elemento
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