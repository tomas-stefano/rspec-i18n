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
        raise(LanguageNilNotFound, "Language -> nil Not Found") unless language
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
      
      def matchers
        keywords["matchers"]
      end
      
      def shared_examples_for_keywords
        spec_keywords('shared_examples_for')
      end
      
      def share_as_keywords
        spec_keywords('share_as')
      end
      
      def it_should_behave_like_keywords
        spec_keywords('it_should_behave_like')
      end
      
      def pending_keywords
        spec_keywords('pending')
      end
      
      def find_matcher(matcher)
        matcher = matcher.to_s
        matcher_and_values = {}        
        matcher_and_values[matcher] = split_word(matchers[matcher])
        matcher_and_values
      end
      
      def word_be(ruby_type)
        matchers_be = keywords_of_be_word
        matcher_ruby_type = keywords['matchers']["#{ruby_type}_word"].to_s.split("|")
        matchers_be.collect do |matcher_be|
          matcher_ruby_type.collect { |matcher| "#{matcher_be}_#{matcher}" }
        end.flatten
      end
      
      def keywords_of_be_word
        return split_word(matchers['be']) if matchers
        []
      end

      def spec_keywords(key)
        raise "No #{key} in #{keywords.inspect}" unless keywords.include?(key)
        return { key => [] } unless keywords[key]
        values = split_word(keywords[key])
        { key => values }
      end
      
      private
      
      def split_word(word)
        word.to_s.split("|")
      end

    end

    class LanguageNotFound < StandardError
    end
    
    class LanguageNilNotFound < StandardError      
    end

  end
end
