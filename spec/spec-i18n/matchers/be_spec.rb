# coding: UTF-8
require 'spec_helper'

describe "should be_predicate" do
  
  context 'when translate the be matcher' do
    
    it "should have the translate method" do
      stub_language!('pt', {'matchers' => {'be' => 'ser'}})
      Spec::Matchers.translate_be_matcher
      methods.sort.to_sym.should include(:ser)          
    end
    
    it "should not raise exception for the be empty keyword" do
      stub_language!('pt', { 'name' => 'Portuguese', 'native' => 'Português'})
      lambda { Spec::Matchers.translate_be_matcher }.should_not raise_exception
    end
    
  end
  
  context 'when method missing' do
    
    before(:each) do
      include Spec::Matchers
      @keywords = { 'matchers' => { 'be' => 'ser' } }
      stub_language!('pt', @keywords)
    end
    
    it "should return a Be Predicate" do
      Spec::Matchers::BePredicate.should_receive(:new).with(:be_something)
      method_missing(:be_something)
    end
    
    it "should not return a Be Predicate" do
      Spec::Matchers::BePredicate.should_not_receive(:new)
      method_missing(:have_something)
    end
    
    it "should return a Has Predicate" do
      Spec::Matchers::Has.should_receive(:new).with(:have_something)
      method_missing(:have_something)
    end
    
    it "should not return a Has Predicate" do
      Spec::Matchers::Has.should_not_receive(:new)
      method_missing(:be_something)
    end
    
    it "when don't have the be word in the language should return a Be Predicate" do
      stub_language!('es', {'name' => 'Spanish', 'native' => 'Español'})
      Spec::Matchers::BePredicate.should_receive(:new).with(:be_something)
      method_missing(:be_something)
    end
    
  end
  
  context 'when have? in method missing' do
    
    before(:each) do
      include Spec::Matchers
    end
        
    it "should return true(0 or anything) for string match" do
      have_predicate?(:have_exactly).should be_true
    end
    
    it "should return true for have at least method" do
      have_predicate?(:have_at_least).should be_true
    end
    
    it "should return true for have at most method" do
      have_predicate?(:have_at_most).should be_true
    end
    
    it "should return false(false or nil) for not string match" do
      have_predicate?(:be_true).should be_false
    end
    
    it "should return nil for not string match" do
      have_predicate?(:be_false).should be_false
    end
    
  end
  
  context 'when be_predicate? in method missing' do
    
    before(:each) do
      include Spec::Matchers
    end
    
    it "should return true for be true string match" do
      be_predicate?(:be_true).should be_true
    end
    
    it "should return true for the be false string match" do
      be_predicate?(:be_false).should be_true
    end
    
    it "should return true for the be_something string match" do
      be_predicate?(:be_something).should be_true
    end
    
    it "should return false for the have string match" do
      be_predicate?(:have).should be_false
    end
    
    it "should return true for the have something string match" do
      be_predicate?(:have_something).should be_false
    end
    
    it "should return true for the have exactly string match" do
      be_predicate?(:have_exactly).should be_false
    end
    
  end
  
  context 'when be predicate' do
    
    before(:each) do
      @keywords = {"matchers" => {"be" => "ser",  "true_word" => "verdadeiro"}}
      stub_language!("pt", @keywords)
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
  
  context 'when be words' do
    
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
  
  context 'when be to english' do
    
    it 'should convert be word to english with two parameters' do
      be_to_english(:ser_feliz, 'ser|estar').should == :be_feliz
    end
    
    it "should convert be words to english" do
      be_to_english(:estar_feliz, 'ser|estar').should == :be_feliz
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