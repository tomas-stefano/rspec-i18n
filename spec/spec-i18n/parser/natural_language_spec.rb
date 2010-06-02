require 'spec_helper'

module SpecI18n
  module Parser
    describe NaturalLanguage do

      before(:each) do
        @pt = NaturalLanguage.new('pt')
        @es = NaturalLanguage.new('es')
        @en = NaturalLanguage.new('en')
        @germany = NaturalLanguage.new('de')
        @portuguese = @pt
        @spanish = @es
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
          keywords = { "should" => "deberia", "should_not" => "no_debe"}
          @es.should_receive(:keywords).at_least(:once).and_return(keywords)
          @es.expectation_keywords.should == { 'should' => ['deberia'], 'should_not' => ['no_debe']}
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
        
        it "should return an empty hash for non exist matchers" do
          stub_keywords!(@portuguese, {'name' => 'Portuguese'})
          @portuguese.matchers.should eql({})
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
    
      describe "when word be" do
        
        context 'when be true keyword' do
                    
          it "should return all the be_true possibilities" do
            keywords = { "matchers" => { 'be' => 'ser|outro_ser', 'true_word' => 'verdade|verdadeiro'} }
            stub_keywords!(@pt, keywords)
            @pt.word_be("true").should eql(["ser_verdade", "ser_verdadeiro", "outro_ser_verdade","outro_ser_verdadeiro"])
          end
          
          it "should return all the be_true possibilities inverted" do
            keywords = { 'matchers' => { 'be' => 'sein', 'true_word' => 'wahr*' }}
            stub_keywords!(@germany, keywords)
            @germany.word_be('true').should eql(['wahr_sein'])
          end
          
          it "should return a empty array for the non keyword" do
            keywords = {}
            stub_keywords!(@germany, keywords)
            @germany.word_be('true').should eql []
          end
          
          it "should return a empty array for the nil be keyword" do
            keywords = { 'matchers' => { 'be' => nil, 'true' => nil }}
            stub_keywords!(@germany, keywords)
            @germany.word_be('true').should eql []
          end
          
          it "should return a empty array for the nil true keyword" do
            keywords = { 'matchers' => { 'be' => 'sein', 'true' => nil}}
            stub_keywords!(@germany, keywords)
            @germany.word_be('true').should eql []
          end
          
        end
        
        context 'when be nil keyword' do
          
          it "should return all the be_nil possibilities" do
            @pt_keywords = { "matchers" => { 'be' => 'ser|outro_ser', 'nil_word' => 'nulo|muito_nulo'}}
            stub_keywords!(@pt, @pt_keywords)
            @pt.word_be("nil").should eql(["ser_nulo", "ser_muito_nulo", "outro_ser_nulo", "outro_ser_muito_nulo"])
          end
          
          it "should return all the be_nil possibilities for the inverted keyword" do
            keywords = { 'matchers' => { 'be' => 'sein', 'nil_word' => "null*" }}
            stub_keywords!(@germany, keywords)
            @germany.word_be('nil').should eql(['null_sein'])
          end
          
          it "should return a empty array for the non matchers keyword" do
            keywords = {}
            stub_keywords!(@es, keywords)
            @es.word_be('nil').should eql []
          end
          
          it "should return a empty array for the non be keyword" do
            keywords = { 'matchers' => { 'be' => nil, 'nil' => nil }}
            stub_keywords!(@en, keywords)
            @en.word_be('nil').should eql []
          end
          
          it "should return a empty array for the non nil keyword" do
            keywords = { 'matchers' => { 'be' => 'ser', 'nil' => nil }}
            stub_keywords!(@pt, keywords)
            @pt.word_be('nil').should eql []
          end

        end
        
        context 'when be false keyword' do
          
          it "should return all the be_false possibilities" do
            @pt_keywords = { 'matchers' => { 'be' => 'ser|outro_ser', 'false_word' => 'falso|muito_falso'}}
            stub_keywords!(@pt, @pt_keywords)
            @pt.word_be("false").should eql(["ser_falso", "ser_muito_falso", "outro_ser_falso", "outro_ser_muito_falso"])
          end
          
          it "should return all the be_false possibilities for the inverted keyword" do
            keywords = { 'matchers' => { 'be' => 'sein', 'false_word' => 'falsch*' }}
            stub_keywords!(@germany, keywords)
            @germany.word_be('false').should eql(['falsch_sein'])
          end
          
          it 'should return a empty array for the non false keyword' do
            keywords = {}
            stub_keywords!(@en, keywords)
            @en.word_be('false').should eql []
          end
          
          it 'should return a empty array for the non false keyword' do
            keywords = { 'matchers' => { 'be' => 'ser', 'false' => nil }}
            stub_keywords!(@es, keywords)
            @es.word_be('false').should eql []
          end
          
        end
        
        context 'when be empty keyword' do
          
          it "should return all the be empty possibilities" do
            keywords = { 'matchers' => { 'be' => 'ser', 'empty_word' => 'vazio|muito_vazio'}}
            stub_keywords!(@portuguese, keywords)
            @portuguese.word_be('empty').should eql(['ser_vazio', 'ser_muito_vazio'])
          end
          
          it "should return the inverted be_empty keyword for keywords with '*' char" do
            keywords = {'matchers' => { 'be' => 'sein', 'empty_word' => 'leer*'}}
            stub_keywords!(@germany, keywords)
            @germany.word_be('empty').should eql(['leer_sein'])
          end
          
        end
        
      end
    
      context 'when invert_order_of_object_and_verbs?' do
        
        it "should return true if the keyword include '*' character" do
          @germany.invert_order_of_object_and_verbs?('wahr*').should be_true
        end
        
        it "should return true if the keyword include '*' char" do
          @portuguese.invert_order_of_object_and_verbs?('verdadeiro*').should be_true
        end
        
        it "should return true if one keyword include '*' char" do
          @germany.invert_order_of_object_and_verbs?('wahr*|verdadeiro').should be_true
        end
        
        it "should return true if the two keywords include '*' char" do
          @portuguese.invert_order_of_object_and_verbs?('wahr*|verdadeiro*').should be_true
        end
        
        it "should return false if the keyword not include '*' character" do
          @portuguese.invert_order_of_object_and_verbs?('verdadeiro').should be_false
        end
        
        it "should return false if the keyword not include '*' char" do
          @spanish.invert_order_of_object_and_verbs?('falso').should be_false
        end
        
        it "should return false if the keyword is nil" do
          @germany.invert_order_of_object_and_verbs?(nil).should be_false
        end
        
      end
      
      context 'when values from keywords' do
        
        it "should return the empty Hash for non values of keyword" do
          stub_keywords!(@portuguese, {})
          @portuguese.values_from_keywords('hooks').should eql({})
        end
        
        it "should return the values for values fo keyword" do
          stub_keywords!(@portuguese, { 'hooks' => { 'each' => 'cada|de_cada'}})
          @portuguese.values_from_keywords('hooks').should eql({'each' => 'cada|de_cada'})
        end
        
        it "should return the empty values for non values of middle keyword" do
          stub_keywords!(@germany, { 'hooks' => {}})
          @germany.values_from_keywords('hooks').should eql({})
        end
        
      end
    
      context '#basic_keywords' do
        
        it "should ignore hooks from keywords" do
          stub_keywords!(@portuguese, { 'subject' => 'assunto', 'hooks' => {'all' => 'todos'}})
          @portuguese.basic_keywords.should eql({'subject' => 'assunto'})
        end
        
        it "should ignore matchers from keywords" do
          stub_keywords!(@portuguese, { 'subject' => 'assunto', 'matchers' => {'be' => 'ser'}})
          @portuguese.basic_keywords.should eql({'subject' => 'assunto'})
        end
        
        it "should ignore matchers and hooks" do
          stub_keywords!(@portuguese, {'describe' => 'descreva', 'should' => 'deve', 'should_not' => 'nao_deve', 'matchers' => {'eql' => 'igl'}, 'hooks' => {'all' => 'todos'}})
          @portuguese.basic_keywords.should eql({'describe' => 'descreva', 'should' => 'deve', 'should_not' => 'nao_deve'})
        end
        
        it "should include all the basic keywords" do
          stub_keywords!(@portuguese, {'describe' => 'descreva', 'matchers' => { 'eql' => 'igual_a'}})
          @portuguese.basic_keywords.should eql({'describe' => 'descreva'})
        end
        
      end
    
      context '#advanced_keywords' do
        
        it "should ignore all the basic keywords" do
          stub_keywords!(@portuguese, {'describe' => 'descreva', 'matchers' => { 'equal' => 'igual' }})
          @portuguese.advanced_keywords.should eql({'matchers' => {'equal' => 'igual'}})
        end
        
        it "should accept hooks keywords" do
          stub_keywords!(@portuguese, {'subject' => 'assunto', 'it' => 'isto', 'hooks' => {'all' => 'todos'}})
          @portuguese.advanced_keywords.should eql({'hooks' => {'all' => 'todos'}})
        end
        
        it "should accept hooks and matchers" do
          stub_keywords!(@portuguese, {'subject' => 'assunto', 'hooks' => {'all' => 'todos'}, 'matchers' => { 'include' => 'inclua' }})
          @portuguese.advanced_keywords.should eql({'hooks' => {'all' => 'todos'}, 'matchers' => {'include' => 'inclua'}})
        end
        
      end
    
    end
  end
end
