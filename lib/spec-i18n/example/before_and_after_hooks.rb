module Spec
  module Example
    module BeforeAndAfterHooks
      
      def register_hooks
        language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
        language.before_and_after_keywords.each do |key, values|
          values.map { |value| alias_method value, key }
        end
      end
  
      def before_parts(scope)
        if SpecI18n.spec_language
          language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
          scope = grep_the_scope(scope, language.hooks_params_keywords)
        end
        case scope
        when :each; before_each_parts
        when :all; before_all_parts
        when :suite; before_suite_parts
        end
      end
      
      def after_parts(scope)
        if SpecI18n.spec_language
          language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
          scope = grep_the_scope(scope, language.hooks_params_keywords)
        end
        case scope
        when :each; after_each_parts
        when :all; after_all_parts
        when :suite; after_suite_parts
        end
      end

      # Receive a String Scope and return the scope in english for
      # the rspec run the right method
      def grep_the_scope(scope, hooks)
        scopes = [:each, :all, :suite]
        return scope if scopes.include?(scope)
        
        hooks.each do |scope_in_english, language_hooks|
          return scope_in_english.to_sym if language_hooks.include?(scope.to_s)
        end
      end

    end
  end
end

include Spec::Example::BeforeAndAfterHooks