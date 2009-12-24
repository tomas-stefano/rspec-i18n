module RspecI18n
  module Parser
    class NaturalLanguage
      KEYWORDS_LANGUAGE = %w{ name native describe before after it should}

      class << self
        def get(language)
          new(language)
        end

        def all
          RspecI18n::SPEC_LANGUAGES.keys.sort.map { |language| get(language) }
        end
      end

      attr_reader :keywords
      
      def initialize(language)
        @keywords = RspecI18n::SPEC_LANGUAGES[language]
        raise "Language Not Supported" if @keywords.nil?
        @parser = nil
      end

      def dsl_keywords
        spec_keywords("describe")
      end

      def expectation_keywords
        spec_keywords("should")
      end

      def spec_keywords(key, space=false)
        raise "No #{key} in #{@keywords.inspect}" if @keywords[key].nil?
        keywords[key].split('|')
      end

    end
  end
end
