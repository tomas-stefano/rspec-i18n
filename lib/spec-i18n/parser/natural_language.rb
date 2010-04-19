module SpecI18n
  module Parser
    class NaturalLanguage
      
      BASIC_KEYWORDS = %w{ name native describe before after it pending subject its should should_not}
                              
      ADVANCED_KEYWORDS = %w{ hooks matchers }
      
      def self.get(language)
        new(language)
      end

      attr_reader :keywords
      
      def initialize(language)
        raise(LanguageNilNotFound, "Language -> nil Not Found") unless language
        @keywords = NaturalLanguage.find_language(language)
        raise(LanguageNotFound, "Language #{language.to_s} Not Supported") if @keywords.nil?
      end
      
      # Find the language in languages.yml and return all the keywords
      #
      def self.find_language(language)
        SpecI18n::SPEC_LANGUAGES[language]
      end
      
      # Return true if the language don't have the basic keywords
      # to work with rspec-i18n
      #
      # portuguese = NaturalLanguage.new('pt') # Assuming Have all the keywords
      #
      # portuguese.incomplete? # => false
      #
      def incomplete?
        language_words = BASIC_KEYWORDS.collect { |key| keywords[key].nil? }
        return true if language_words.include?(true)
        false
      end

      # Return the describe word in the languages.yml
      # 
      def dsl_keywords
        spec_keywords("describe")
      end
      
      # Return the should and should_not words in the languages.yml
      #
      def expectation_keywords
        spec_keywords("should").merge(spec_keywords("should_not"))
      end
      
      # Return the before and after words in the languages.yml
      #
      def before_and_after_keywords
        spec_keywords("before").merge(spec_keywords("after"))
      end
      
      # Return all the hooks words in the languages.yml
      # The hooks in the rspec is the argument for before and after method
      #
      #       hook                hook
      #         \                 /
      # before(:each)     after(:all)
      #
      def hooks_params_keywords
        hooks = {}
        keywords['hooks'].each do |hook, value|
          values = split_word(value)
          hooks[hook] = values
        end
        hooks
      end
      
      # Return the it word in the languages.yml
      #
      def example_group_keywords
        spec_keywords("it")
      end

      # Return the subject word in the languages.yml
      #
      def subject_keywords
        adverbs = spec_keywords('subject')
      end

      # Return the its keywords in the languages.yml
      #
      def its_keywords
        spec_keywords("its")
      end
      
      # Return All the Matchers in the languages.yml
      #
      def matchers
        keywords["matchers"]
      end
      
      # Return the shared examples for words in the languages.yml
      #
      def shared_examples_for_keywords
        spec_keywords('shared_examples_for')
      end
      
      # Return the share_as words in the languages.yml
      #
      def share_as_keywords
        spec_keywords('share_as')
      end
      
      # Return the it should behave like words in the languages.yml
      #
      def it_should_behave_like_keywords
        spec_keywords('it_should_behave_like')
      end
      
      # Return the pending words in the languages.yml
      #
      def pending_keywords
        spec_keywords('pending')
      end
      
      # Find the matcher and return the words in the languages.yml
      #
      # pt: matchers: equal: igual|igual_a
      # NaturalLanguage.new('pt').find_matcher('equal') # => { 'equal' => ['igual', 'igual_a']}
      #
      def find_matcher(matcher)
        matcher = matcher.to_s
        matcher_and_values = {}        
        matcher_and_values[matcher] = split_word(matchers[matcher])
        matcher_and_values
      end
      
      # Return the keywords of be_* matchers in the languages.yml
      #
      # pt: 
      #   matchers: 
      #     be: ser
      #     true_word: verdadeiro|verdade
      #
      # NaturalLanguage.new('pt').word_be('true') # => ['ser_verdadeiro', 'ser_verdade']
      #
      def word_be(ruby_type)
        matchers_be = keywords_of_be_word
        matcher_ruby_type = split_word(keywords['matchers']["#{ruby_type}_word"])
        matchers_be.collect! do |matcher_be|
          matcher_ruby_type.collect { |matcher| "#{matcher_be}_#{matcher}" }
        end
        matchers_be.flatten
      end
      
      # Return the be words in the languages.yml
      #
      def keywords_of_be_word
        return split_word(matchers['be']) if matchers
        []
      end

      # Return the words of languages.yml in a Hash with Array values
      #
      # pt:
      #   describe: descreva|descrevendo
      #
      # NaturalLanguage.new('pt').spec_keywords('describe') # => { 'describe' => ['descreva', 'descrevendo']}
      #
      # fr:
      # should:
      #
      # NaturalLanguage.new('fr').spec_keywords('should') # => { 'should' => [] } 
      #
      #
      # NaturalLanguage.new('es').spec_keywords('key_not_found') # => RuntimeError: "No key_not_found in #{keywords}"
      #
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
