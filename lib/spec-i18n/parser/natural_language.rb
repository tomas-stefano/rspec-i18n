module SpecI18n
  module Parser
    class NaturalLanguage
      KEYWORDS_LANGUAGE = %w{ name native describe before after it should}

      class << self
        def get(language)
          new(language)
        end
        
        def list_languages
          SpecI18n::SPEC_LANGUAGES.keys.sort.map do |lang|
            [
              lang, 
              SpecI18n::SPEC_LANGUAGES[lang]['name'], 
              SpecI18n::SPEC_LANGUAGES[lang]['native']
            ]
          end
        end
        
      end

      attr_reader :keywords
      
      def initialize(language)
        @keywords = SpecI18n::SPEC_LANGUAGES[language]
        raise(LanguageNotFound, "Language #{language} Not Supported") if @keywords.nil?
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