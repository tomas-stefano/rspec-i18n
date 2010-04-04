require 'spec_helper'

module Spec
  module Example
    describe BeforeAndAfterHooks do
      
      before(:each) do
        @pt = SpecI18n::Parser::NaturalLanguage.get("pt")
        @es = SpecI18n::Parser::NaturalLanguage.get("es")
        @pt_keywords = {"before" => "antes", "after" => "antes",
          "hooks" => {"each" => "cada", "all" => "todos", 
                      "suite" => "suite"}}
        @es_keywords = { "before" => "antes", "after" => "antes",
          "hooks" => {"each" => "cada", "all" => "tudo",
                      "suite" => "suite"}}
        @pt.stub!(:keywords).and_return(@pt_keywords)
        @es.stub!(:keywords).and_return(@es_keywords)
        @languages = {"pt" => @pt, "es" => @es}
      end
      
      it "should include all i18n methods to Before and After Hooks" do
        @languages.each do |lang, language|
          SpecI18n.stub!(:natural_language).and_return(language)
          Spec::Example::BeforeAndAfterHooks.register_hooks
          language.before_and_after_keywords.keys.map do |keyword|
            methods = BeforeAndAfterHooks.methods.all_to_symbols
            methods.should include(keyword.to_sym)
          end
        end
      end
      
      context "the before hook" do
        
        it "should translate the :each parameters and parse options" do
          @languages.each do |lang, language|
            SpecI18n.stub!(:spec_language).and_return(lang)            
            SpecI18n.stub!(:natural_language).and_return(language)
            scope = language.hooks_params_keywords["each"].first
            self.should_receive(:before_each_parts)
            before_parts(scope)
          end
        end
    
        it "should translate the :all scope and call the right method" do
          @languages.each do |lang, language|
            SpecI18n.stub!(:spec_language).and_return(lang)            
            SpecI18n.stub!(:natural_language).and_return(language)
            scope = language.hooks_params_keywords["all"].first
            self.should_receive(:before_all_parts)
            before_parts(scope)
          end
        end
    
        it "should translate the :suite scope and call the right method" do
          @languages.each do |lang, language|
            SpecI18n.stub!(:spec_language).and_return(lang)            
            SpecI18n.stub!(:natural_language).and_return(language)
            scope = language.hooks_params_keywords["suite"].first
            self.should_receive(:before_suite_parts)
            before_parts(scope)
          end
        end
      end
      
      context "the after hook" do
        it "should translate the :all scope and call the right method" do
          @languages.each do |lang, language|
            SpecI18n.stub!(:spec_language).and_return(lang)            
            SpecI18n.stub!(:natural_language).and_return(language)
            scope = language.hooks_params_keywords["all"].first
            self.should_receive(:after_all_parts)
            after_parts(scope)
          end
        end
      end
      
      context "grep the scope and call the hook" do
        
        before(:each) do
          @pt = Spec::Runner.configuration.spec_language(:pt)
          @language = SpecI18n::Parser::NaturalLanguage.get(@pt)
          @hooks = @language.hooks_params_keywords 
        end
        
        it "should return the same scope if scope is in English" do
          [:each, :all, :suite].each do |scope|
            grep_the_scope(scope, @hooks).should == scope
          end
        end
        
        it "should grep the scope each" do
          scopes = @hooks["each"]
          scopes.each do |scope|
            grep_the_scope(scope, @hooks).should == :each            
          end
        end
        
        it "should grep the scope all" do
          scopes = @hooks["all"]
          scopes.each do |scope|
            grep_the_scope(scope, @hooks).should == :all
          end
        end
        
        it "should grep the scope suite" do
          scopes = @hooks["suite"]
          scopes.each do |scope|
            grep_the_scope(scope, @hooks).should == :suite            
          end
        end
        
        context "with Symbol scopes" do
          
          it "should grep the scope :each" do
            scopes = @hooks["each"].map { |hook| hook.to_sym }
            scopes.each do |scope|
              grep_the_scope(scope, @hooks).should == :each
            end
          end

          it "should grep the scope :all" do
            scopes = @hooks["all"].map { |hook| hook.to_sym }
            scopes.each do |scope|
              grep_the_scope(scope, @hooks).should == :all
            end
          end
          
          it "should grep the scope :suite" do
            scopes = @hooks["suite"].map { |hook| hook.to_sym }
            scopes.each do |scope|
              grep_the_scope(scope, @hooks).should == :suite
            end
          end
          
        end
      end
          
    end
  end
end
