module Spec
  module DSL
    module Main

      # Register adverbs for the dsl keywords
      #
      # { "describe" => ["descreva", "contexto"]}
      # 
      # Register alias for the language specified
      def register_adverbs
        language = SpecI18n.natural_language
        @adverbs = language.dsl_keywords
        @adverbs.each do |key, values|
          values.map { |value| alias_method value, key }
        end
      end

    end
  end
end

include Spec::DSL::Main
