module SpecI18n
  module Parser
    class NaturalLanguage
      BASIC_KEYWORDS = %w{ name native describe before after it 
                           subject its should should_not}
                              
      ADVANCED_KEYWORDS = %w{ hooks matchers}
      
      def self.get(language)
        new(language)
      end

      attr_reader :keywords
      
      def initialize(language)
        @keywords = NaturalLanguage.find_language(language)
        raise(LanguageNotFound, "Language #{language.to_s} Not Supported") if @keywords.nil?
      end
      
      def self.find_language(language)
        SpecI18n::SPEC_LANGUAGES[language]
      end
      
      def incomplete?
        language_words = BASIC_KEYWORDS.collect { |key| keywords[key].nil? }
        return true if language_words.include?(true)
        false
      end

      def dsl_keywords
        spec_keywords("describe")
      end

      def expectation_keywords
        language_adverbs = spec_keywords("should")
        language_adverbs.merge(spec_keywords("should_not"))
      end
      
      def before_and_after_keywords
        adverbs = spec_keywords("before")
        adverbs.merge(spec_keywords("after"))
      end
      
      def hooks_params_keywords
        hooks = {}
        keywords['hooks'].each do |hook, value|
          values = value.split('|')
          hooks[hook] = values
        end
        hooks
      end
      
      def example_group_keywords
        spec_keywords("it")
      end

      def subject_keywords
        adverbs = spec_keywords('subject')
      end

      def its_keywords
        spec_keywords("its")
      end
      
      def word_be(ruby_type)
        matchers_be = keywords['matchers']['be'].to_s.split("|")
        matcher_ruby_type = keywords['matchers']["#{ruby_type}_word"].to_s.split("|")
        matchers_be.collect do |matcher_be|
          matcher_ruby_type.collect { |matcher| "#{matcher_be}_#{matcher}" }
        end.flatten
      end

      def spec_keywords(key)
        raise "No #{key} in #{keywords.inspect}" unless keywords.include?(key)
        unless keywords[key]
          return { key => [] }
        end
        values = keywords[key].split('|')
        { key => values }
      end

    end

    class LanguageNotFound < StandardError
    end

  end
end
