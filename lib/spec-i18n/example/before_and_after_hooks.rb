module Spec
  module Example
    module BeforeAndAfterHooks
      
      def register_hooks
        language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
        language.before_and_after_keywords.each do |key, values|
          values.map { |value| alias_method value, key }
        end
      end
  
      def before_parts(scope, test=nil)
        if SpecI18n.spec_language
          language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
          debugger
          before_each_parts
        else
          case scope
          when :each; before_each_parts
          when :all; before_all_parts
          when :suite; before_suite_parts
          end
        end
      end
    end
  end
end

include Spec::Example::BeforeAndAfterHooks