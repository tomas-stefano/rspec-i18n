module Spec
  module Example
    module BeforeAndAfterHooks
      
      # Translate hooks(before and after) keywords
      #
      def register_hooks
        natural_language.before_and_after_keywords.each do |key, values|
          values.collect { |value| alias_method value, key }
        end
      end
  
      # OverWriting a methor for rspec to work with hooks parameters
      #
      def before_parts(scope)

        scope = grep_language_and_scope(scope) || scope

        case scope
        when :each; before_each_parts
        when :all; before_all_parts
        when :suite; before_suite_parts
        end
      end
      
      # OverWriting a methor for rspec to work with hooks parameters
      #
      def after_parts(scope)
        
        scope = grep_language_and_scope(scope)
        
        case scope
        when :each; after_each_parts
        when :all; after_all_parts
        when :suite; after_suite_parts
        end
      end
      
      def grep_language_and_scope(scope)
        if SpecI18n.spec_language
          hooks = natural_language.hooks_params_keywords
          scope = grep_the_scope(scope, hooks)
        else
          scope
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