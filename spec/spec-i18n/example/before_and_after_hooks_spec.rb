require 'spec_helper'

module Spec
  module Example
    describe BeforeAndAfterHooks do
            
      describe 'when translate the hooks' do
        
        context 'when portuguese' do
          
          before(:each) do
            @keywords = { 'before' => 'antes|anterior', 'after' => 'depois|posterior' }
            stub_language!('pt', @keywords)
            Spec::Example::BeforeAndAfterHooks.register_hooks
          end

          it "should include all i18n methods to Before Hooks" do
            name_methods = BeforeAndAfterHooks.methods.to_symbols
            [:antes, :anterior].each do |translated_method|
              name_methods.should include(translated_method)
            end
          end
          
          it "should include all i18n methods to After Hooks" do
            name_methods = BeforeAndAfterHooks.methods.to_symbols
            [:depois, :posterior].each do |translated_method|
              name_methods.should include(translated_method)
            end
          end
          
        end
            
      end
      
      context "the before hook" do
        
        before(:each) do
          @pt = NaturalLanguage.new('pt')
          @keywords = { 'hooks' => { 'each' => 'cada|de_cada', 'all' => 'todos|de_todos', 'suite' => 'suite|da_suite'}}
          SpecI18n.should_receive(:spec_language).and_return('pt')
          stub_keywords!(@pt, @keywords)
        end
        
        it "should translate the :each parameters and parse options" do
          scopes = [:cada, :de_cada]
          BeforeAndAfterHooks.should_receive(:before_each_parts)
          scopes.each do |scope|
            BeforeAndAfterHooks.before_parts(scope)
          end
        end
        
      end
      
      context "the after hook" do
        
      end
      
      context "grep the scope and call the hook" do
        
        before(:each) do
          @hooks = { 'each' => 'cada|de_cada', 'all' => 'todos|de_todos', 'suite' => 'suite|da_suite' }
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
          
#         it "should grep the scope :each" do
#           scopes = @hooks["each"].map { |hook| hook.to_sym }
#           scopes.each do |scope|
#             grep_the_scope(scope, @hooks).should == :each
#           end
#         end
#
#         it "should grep the scope :all" do
#           scopes = @hooks["all"].map { |hook| hook.to_sym }
#           scopes.each do |scope|
#             grep_the_scope(scope, @hooks).should == :all
#           end
#         end
#         
#         it "should grep the scope :suite" do
#           scopes = @hooks["suite"].map { |hook| hook.to_sym }
#           scopes.each do |scope|
#             grep_the_scope(scope, @hooks).should == :suite
#           end
#         end
          
        end
      
      end
          
    end
  end
end
