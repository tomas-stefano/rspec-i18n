module Spec
  module DSL
    module Main

      def register_adverbs
        spec_language = Spec::Runner.configuration.language
        language = SpecI18n::Parser::NaturalLanguage.get(spec_language)
        @adverbs = language.dsl_keywords
        @adverbs.each do |adverb|
          alias_adverb(adverb)
        end
      end

      def alias_adverb(adverb)
        alias_method adverb.to_sym, :describe
      end

    end
  end
end

include Spec::DSL::Main
