require 'spec_helper'

module SpecI18n
  module Parser
    describe NaturalLanguage do

      before(:each) do
        @pt = NaturalLanguage.new('pt')
        @es = NaturalLanguage.new('es')
        @en = NaturalLanguage.new('en')
      end
      
      context "get languages" do
        
        it "should get the default language" do
          NaturalLanguage.get("en").should_not be_nil
        end
        
        it "should raise for the non existing language" do
          language = "non_existing"
          lambda {  
            NaturalLanguage.new(language) 
          }.should raise_exception(LanguageNotFound, "Language #{language} Not Supported")
        end
        
        it "should raise a error for the NIL language" do
          lambda {
            NaturalLanguage.new(nil)
          }.should raise_exception(LanguageNilNotFound, "Language -> nil Not Found")
        end

      end
      
      context "incomplete languages" do
        
        it "should return false for the complete language" do
          @pt.incomplete?.should be_false
        end
        
        it "should return true for the incomplete language" do
          @pt.stub!(:keywords).and_return({})
          @pt.incomplete?.should be_true
        end
                
      end
      
      context "of dsl keywords" do
      
        it "should return the describe dsl keyword" do
          lang = { "describe" => "descreva", :before => "antes" }
          @pt.should_receive(:keywords).at_least(:once).and_return(lang)
          @pt.dsl_keywords.should == { "describe" => [ lang["describe"] ] }
        end
      end

      context "of expectations keywords" do
        
        before(:each) do
          @keywords = { "should" => ["deve"], "should_not" => ["nao_deve"] }
        end

        it "should return the expectation keyword of the language" do
          lang = {"describe" => "descreva", "should" => "deve", "should_not" => "nao_deve"}
          @pt.should_receive(:keywords).at_least(:once).and_return(lang)
          @pt.expectation_keywords.should == @keywords
        end
        
        it "should return the expectation keywords of the current language" do
          keywords = { "should" => ["deberia"], "should_not" => ["no_debe"]}
          @es.should_receive(:keywords).at_least(:once).and_return(keywords)
          @es.expectation_keywords.should == keywords
        end
      end
      
      context "of before and after keywords" do
        
        before(:each) do
          @language = { "before" => "before", "after" => "after"}
        end
        
        it "should return the hooks for the current language" do
          @en.should_receive(:keywords).at_least(:once).and_return(@language)
          keywords = { "before" => ["before"], "after" => ["after"]}
          @en.before_and_after_keywords.should == keywords
        end
        
        it "should return the hooks for the language" do
          language = {"before" => "antes", "after" => "depois"}
          keywords = { "before" => ["antes"], "after" => ["depois"]}
          @pt.stub!(:keywords).and_return(language)
          @pt.before_and_after_keywords.should == keywords
        end
      end
      
      context "of hooks keywords" do
        
        before(:each) do
          @lang = { "hooks" => {"each" => "de_cada|de_cada_exemplo", 
                    "all" => "de_todos|de_todos_exemplos",
                    "suite" => "suite"}}
          @keywords = { "each" => ["de_cada", "de_cada_exemplo"], 
                       "all" => ["de_todos", "de_todos_exemplos"],
                       "suite" => ["suite"]}
        end
        
        it "should return the hooks parameters for the current language" do
          @pt.stub!(:keywords).and_return(@lang)
          @pt.hooks_params_keywords.should == @keywords                       
        end
      end
      
      context "of example group keywords" do
        
        before(:each) do
          @keywords = { "it" => ["exemplo", "especificar"] }
        end
        
        it "should return the example group keywords for the current language" do
          lang = { "it" => "exemplo|especificar", "describe" => "descreva" }
          @pt.stub!(:keywords).and_return(lang)
          @pt.example_group_keywords.should == @keywords
        end
        
      end

      context 'of example subject keywords' do
        
        before(:each) do
          @keywords = { "subject" => "assunto|tema" }
          @spanish_keywords = { 'subject' => 'asunto|tema'}
        end

        it 'should return the subject keywords' do
          @pt.should_receive(:keywords).at_least(:once).and_return(@keywords)
          @pt.subject_keywords.should == {'subject' => ["assunto", "tema"]}
        end

        it 'should return the subject keywords for spanish language' do
          @es.should_receive(:keywords).at_least(:once).and_return(@spanish_keywords)
          @es.subject_keywords.should == { 'subject' => ['asunto', 'tema']}
        end
      end

      context 'of example its keywords' do
        
        before(:each) do
          @keywords = { "its" => "exemplos" }
          @spanish_keywords = { 'its' => 'ejemplos'}
        end

        it 'should return the its keywords' do
          @pt.stub!(:keywords).and_return(@keywords)
          @pt.its_keywords.should == {'its' => ["exemplos"]}
        end

        it 'should return the its keywords for spanish language' do
          @es.stub!(:keywords).and_return(@spanish_keywords)
          @es.its_keywords.should == { 'its' => ['ejemplos']}
        end
      end
      
      context 'matchers' do
        
        before(:each) do
          @keywords = { "matchers" => { "be" => "ser", 
            "include" => "incluir|incluso", "be_close" => nil}}
        end
        
        it "should return an hash of matchers" do
          stub_keywords!(@pt, @keywords)
          @pt.matchers.should == @keywords["matchers"]
        end
        
        it "should find a matcher that exist" do
          stub_keywords!(@pt, @keywords)
          @pt.find_matcher(:include).should == { "include" => ["incluir", "incluso"]}
        end
        
        it "should return a hash with empty value for the empty value of matcher" do
          stub_keywords!(@pt, @keywords)
          @pt.find_matcher(:be_close).should == {"be_close" => []}
        end
        
      end
      
      context 'shared examples keywords' do
        
        before(:each) do
          @keywords = { 'shared_examples_for' => 'exemplos_distribuidos|distribuido',
          'it_should_behave_like' => 'deve_se_comportar_como|deve_se_comportar',
          'share_as' => 'distribua|distribua_como' }
          stub_keywords!(@pt, @keywords)
        end
        
        it "should return the words for shared examples for separated by '|'" do
          expected = {"shared_examples_for" => ['exemplos_distribuidos', 'distribuido']}
          @pt.shared_examples_for_keywords.should ==(expected)
        end
        
        it "should return the words for it should behave like keyword" do
          expected = {"it_should_behave_like" => ['deve_se_comportar_como', 'deve_se_comportar']}
          @pt.it_should_behave_like_keywords.should ==(expected)
        end
        
        it "should return the words for shares as keyword" do
          expected = { 'share_as' => ['distribua', 'distribua_como']}
          @pt.share_as_keywords.should == expected
        end
        
      end
      
      context 'when pending keywords' do
        
        it "should return the pending keywords" do
          @keywords = { 'pending' => 'pendente|pendencia' }
          stub_keywords!(@pt, @keywords)
          @pt.pending_keywords.should == { 'pending' => ['pendente', 'pendencia']}
        end
        
        it "should return the pending keywords for languages" do
          @keywords = { 'pending' => 'spec_pendente'}
          stub_keywords!(@es, @keywords)
          @es.pending_keywords.should == { 'pending' => ['spec_pendente']}
        end
        
      end
      
      context "be keyword" do
        before(:each) do
          @keywords = { "matchers" => { "be" => "ser|estar" }}
        end
        
        it "should return an array with values of be word" do
          stub_keywords!(@pt, @keywords)
          @pt.keywords_of_be_word.should == ["ser", "estar"]
        end
        
        it "should return a empty array for non found keyword" do
          stub_keywords!(@pt, {})
          @pt.keywords_of_be_word.should == []
        end
        
      end
      
      context "splitting the keys" do
        
        it "should raise no found key" do
          lambda {
            @pt.spec_keywords("no_found")            
          }.should raise_exception(RuntimeError)
        end
        
        it "should raise exception for not found key" do
          lambda {
            @pt.spec_keywords("Oh_MY_this_words_is_not_found!")
          }.should raise_exception(RuntimeError)
        end
        
        it "should not raise error for key found but key is nil" do
          lang = { 'describe' => nil}
          @pt.stub!(:keywords).and_return(lang)
          @pt.spec_keywords("describe").should == { 'describe' => []}
        end

        it "should split correctly the keys" do
         lang = { "describe" => "descreva|contexto" }
         @pt.stub!(:keywords).and_return(lang)
         @pt.spec_keywords("describe").should == { "describe" => ["descreva", "contexto"] }
        end
      end
    
      context "be_true, be_false and be_nil" do
        
        it "should return all the be_true possibilities" do
          lang = { "matchers" => { 'be' => 'ser|outro_ser', 'true_word' => 'verdade|verdadeiro'}}
          expected_words = ["ser_verdadeiro", "ser_verdade", "outro_ser_verdade","outro_ser_verdadeiro"]
          @pt.stub!(:keywords).and_return(lang)
          expected_words.each do |expected|
            @pt.word_be("true").should include expected
          end
        end
        
        it "should return all the be_nil possibilities" do
          lang = { "matchers" => { 'be' => 'ser|outro_ser', 'nil_word' => 'nulo|muito_nulo'}}
          expected_words = ["ser_nulo", "ser_muito_nulo"]
          @pt.stub!(:keywords).and_return(lang)
          expected_words.each do |expected|
            @pt.word_be("nil").should include expected
          end
        end
        
        it "should return all the be_false possibilities" do
          lang = { "matchers" => { 'be' => 'ser|outro_ser', 'false_word' => 'falso|muito_falso'}}
          expected_words = ["ser_falso", "ser_muito_falso"]
          @pt.stub!(:keywords).and_return(lang)
          expected_words.each do |expected|
            @pt.word_be("false").should include expected
          end
        end
        
      end
    
    end
  end
end
