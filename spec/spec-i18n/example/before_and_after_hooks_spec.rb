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
      
      describe 'when hooks' do
        
        before(:each) do
           SpecI18n.stub!(:spec_language).and_return('pt')
           @keywords = { 'hooks' => { 'each' => 'cada|de_cada', 'all' => 'todos|de_todos', 'suite' => 'suite|da_suite'}}
           stub_language!('pt', @keywords)
        end
              
        describe "the before hook" do
          
          context 'when :each' do
                  
            it "should translate the :each parameters and parse options" do
              [:cada, :de_cada].each do |scope|
                BeforeAndAfterHooks.should_receive(:before_each_parts)
                BeforeAndAfterHooks.before_parts(scope)
              end
            end
            
            it "should not call the :all parameters for :each hook" do
              BeforeAndAfterHooks.should_not_receive(:before_all_parts)
              [:cada, :de_cada].each do |scope|                 
                BeforeAndAfterHooks.before_parts(scope)              
              end
            end
            
            it "should not call the :suite parameters for :suite hook" do
              BeforeAndAfterHooks.should_not_receive(:before_suite_parts)
              [:cada, :de_cada].each do |scope|                 
                BeforeAndAfterHooks.before_parts(scope)
              end
            end
          end
          
          context 'when :all' do
             
             it "should translate the :all parameter" do
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.should_receive(:before_all_parts)
                 BeforeAndAfterHooks.before_parts(scope)
               end
             end
             
             it "should not call the :each parameter" do
               BeforeAndAfterHooks.should_not_receive(:before_each_parts)
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.before_parts(scope)
               end
             end
             
             it "should not call the :suite parameter" do
               BeforeAndAfterHooks.should_not_receive(:before_suite_parts)
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.before_parts(scope)
               end
             end
             
           end
          
          context 'when :suite' do
            
            it "should translate the :suite parameter" do
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.should_receive(:before_suite_parts)
                BeforeAndAfterHooks.before_parts(scope)
              end
            end
            
            it "should not call the :each parameter" do
                BeforeAndAfterHooks.should_not_receive(:before_each_parts)
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.before_parts(scope)
              end
            end
            
            it "should not call the :all parameter" do
              BeforeAndAfterHooks.should_not_receive(:before_all_parts)
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.before_parts(scope)
              end
            end
            
          end
            
        end
      
        context "the after hook" do
          
          context 'when :each' do
                  
            it "should translate the :each parameters and parse options" do
              [:cada, :de_cada].each do |scope|
                BeforeAndAfterHooks.should_receive(:after_each_parts)
                BeforeAndAfterHooks.after_parts(scope)
              end
            end
            
            it "should not call the :all parameters for :each hook" do
              BeforeAndAfterHooks.should_not_receive(:after_all_parts)
              [:cada, :de_cada].each do |scope|                 
                BeforeAndAfterHooks.after_parts(scope)              
              end
            end
            
            it "should not call the :suite parameters for :suite hook" do
              BeforeAndAfterHooks.should_not_receive(:after_suite_parts)
              [:cada, :de_cada].each do |scope|                 
                BeforeAndAfterHooks.after_parts(scope)
              end
            end
          end
          
          context 'when :all' do
             
             it "should translate the :all parameter" do
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.should_receive(:after_all_parts)
                 BeforeAndAfterHooks.after_parts(scope)
               end
             end
             
             it "should not call the :each parameter" do
               BeforeAndAfterHooks.should_not_receive(:after_each_parts)
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.after_parts(scope)
               end
             end
             
             it "should not call the :suite parameter" do
               BeforeAndAfterHooks.should_not_receive(:after_suite_parts)
               [:todos, :de_todos].each do |scope|
                 BeforeAndAfterHooks.after_parts(scope)
               end
             end
             
          end
        
          context 'when :suite' do
            
            it "should translate the :suite parameter" do
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.should_receive(:after_suite_parts)
                BeforeAndAfterHooks.after_parts(scope)
              end
            end
            
            it "should not call the :each parameter" do
                BeforeAndAfterHooks.should_not_receive(:after_each_parts)
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.after_parts(scope)
              end
            end
            
            it "should not call the :all parameter" do
              BeforeAndAfterHooks.should_not_receive(:after_all_parts)
              [:suite, :da_suite].each do |scope|
                BeforeAndAfterHooks.after_parts(scope)
              end
            end
            
          end
        
        end
        
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
        
        context 'with String scope parameters' do
          
          it "should grep the scope each in translated values" do
            ['cada', 'de_cada'].each do |scope|
              grep_the_scope(scope, @hooks).should == :each            
            end
          end

          it "should grep the scope all in translated values" do
            ['todos', 'de_todos'].each do |scope|
              grep_the_scope(scope, @hooks).should == :all
            end
          end

          it "should grep the scope suite in translated values" do
            ['suite', 'da_suite'].each do |scope|
              grep_the_scope(scope, @hooks).should == :suite            
            end
          end
        
        end
        
        context "with Symbol scope parameters" do
          
          it "should grep the scope each in translated values" do
            [:cada, :de_cada].each do |scope|
              grep_the_scope(scope, @hooks).should == :each            
            end
          end

          it "should grep the scope all in translated values" do
            [:todos, :de_todos].each do |scope|
              grep_the_scope(scope, @hooks).should == :all
            end
          end

          it "should grep the scope suite in translated values" do
            [:suite, :da_suite].each do |scope|
              grep_the_scope(scope, @hooks).should == :suite            
            end
          end
          
        end
      
      end
          
    end
  end
end
