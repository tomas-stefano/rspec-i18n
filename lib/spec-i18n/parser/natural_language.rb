module SpecI18n
  module Parser
    class NaturalLanguage
      BASIC_KEYWORDS = %w{ name native describe before after it 
                              should should_not}
                              
      ADVANCED_KEYWORDS = %w{ hooks matchers}
      
      class << self
        def get(language)
          new(language)
        end
        
        def list_languages
          SpecI18n::SPEC_LANGUAGES.keys.sort.map do |lang|
            [ lang, grep_value(lang, 'name'), grep_value(lang, 'native') ]
          end
        end
        
        def grep_value(lang, key)
          SpecI18n::SPEC_LANGUAGES[lang][key]
        end
        
        def list_basic_keywords(language)
          language = NaturalLanguage.get(language)
          BASIC_KEYWORDS.map do |keyword|
            words = language.keywords[keyword]            
            [keyword, words.split('|').join(' / ')]
          end
        end
        
        def list_advanced_keywords(language)
          ADVANCED_KEYWORDS.map do |keyword|
            [keyword, '']
          end
        end
        
        def grep_the_values(words)
          words.collect { |k, v| "\n- :#{k} => #{v.split('|').join(' / ')} " }.to_s
        end
        
      end

      attr_reader :keywords
      
      def initialize(language)
        @keywords = SpecI18n::SPEC_LANGUAGES[language]
        raise(LanguageNotFound, "Language #{language.to_s} Not Supported") if @keywords.nil?
      end
      
      def incomplete?
        language_words = BASIC_KEYWORDS.collect { |key| keywords[key].nil? }
        return false if language_words.include?(true)
        true
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

      def spec_keywords(key, space=false)
        raise "No #{key} in #{@keywords.inspect}" if @keywords[key].nil?
        values = keywords[key].split('|')
        { key => values }
      end

    end

    class LanguageNotFound < StandardError
    end

  end
end