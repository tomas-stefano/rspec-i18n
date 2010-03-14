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
  
  context "be words" do
    before(:each) do
      @pt = Parser::NaturalLanguage.get("pt")
      @es = Parser::NaturalLanguage.get("es")
      include Spec::Matchers
      @pt_keywords = { "matchers" => {'be' => 'ser',
        "true_word" => "verdadeiro", "empty_word" => "vazio",
        "false_word" => "falso", 'nil_word' => 'nulo'}}
      @pt.stub!(:keywords).and_return(@pt_keywords)
      @es_keywords = { "matchers" => {'be' => 'ser',
        "true_word" => "verdadero", "false_word" => "falso", 
        'nil_word' => 'nulo', 'empty_word' => "vazio"}}
      @es.stub!(:keywords).and_return(@es_keywords)
    end
    
    ['true', 'false', 'nil', 'empty'].each do |ruby_type|
      context "be #{ruby_type}" do
          
        it "should translate #{ruby_type} keyword for pt" do
          SpecI18n.stub!(:natural_language).and_return(@pt)
          matcher_be = "#{@pt_keywords['matchers']['be']}"
          matcher = @pt_keywords['matchers']["#{ruby_type}_word"]
          expected = "#{matcher_be}_#{matcher}"
          eval <<-MATCHER
            Be.matcher_be_some(:#{ruby_type} => true).should == [expected.to_sym ]
          MATCHER
        end
        
         it "should translate #{ruby_type} keyword for es" do
           SpecI18n.stub!(:natural_language).and_return(@es) 
           matcher_be = "#{@es_keywords['matchers']['be']}"
           matcher = @es_keywords['matchers']["#{ruby_type}_word"]
           expected = "#{matcher_be}_#{matcher}"
           eval <<-MATCHER
             Be.matcher_be_some(:#{ruby_type} => true).should == [expected.to_sym ]
           MATCHER
         end
      end
    end
    
    context "be true predicate" do
         
      it "should pass when actual equal?(true)" do
          [@pt, @es].each do |language|
            SpecI18n.stub!(:natural_language).and_return(language)
            Be.translate_be_true
            matcher_be_some(:true => true).each do |word_be_true|
                eval <<-BE_TRUE
                  true.should #{word_be_true}
                  1.should #{word_be_true}
                BE_TRUE
            end
          end
        end
      
    end

    context "be false predicate" do
      
      it "should pass when actual equal?(true)" do
          [@pt, @es].each do |language|
            SpecI18n.stub!(:natural_language).and_return(language)
            Be.translate_be_false
            matcher_be_some(:false => true).each do |word_be_false|
                eval <<-BE_FALSE
                  false.should #{word_be_false}
                  nil.should #{word_be_false}
                BE_FALSE
            end
          end
        end
      
      
    end
    
    context "be nil predicate" do
        
      it "should pass when actual is nil" do
        [@pt, @es].each do |language|
          SpecI18n.stub!(:natural_language).and_return(language)
          Be.translate_be_nil
          matcher_be_some(:nil => true).each do |word_be_nil|
              eval <<-BE_NIL                
                nil.should #{word_be_nil}
              BE_NIL
          end
        end
      end
    end
    
    context "be empty predicate" do
      it "should pass when actual is nil" do
        [@pt, @es].each do |language|
          SpecI18n.stub!(:natural_language).and_return(language)
          Be.translate_be_empty
          matcher_be_some(:empty => true).each do |word_be_nil|
              eval <<-BE_EMPTY                
                [].should #{word_be_nil}
              BE_EMPTY
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