module Spec
  module DSL
    module Main

      # Register adverbs for the dsl keywords
      #
      # { "describe" => ["descreva", "contexto"]}
      # 
      # Register alias for the language specified
      def register_adverbs
        natural_language.dsl_keywords.each do |key, values|
          values.map { |value| alias_method value, key }
        end
      end

      # Register adverbs for the shared_examples_for keyword
      #
      # { "shared_examples_for" => ['exemplos_distribuidos_para']}
      #
      def translate_shared_examples_for
        natural_language.shared_examples_for_keywords.each do |shared_examples_method, shared_example_keywords|
          shared_example_keywords.each { |keyword| alias_method keyword, shared_examples_method }
        end
      end
      
      def translate_share_as_keywords
        natural_language.share_as_keywords.each do |share_as_method, share_as_keywords|
          share_as_keywords.each { |keyword| alias_method keyword, share_as_method }
        end
      end
      
    end
  end
end

include Spec::DSL::Main
