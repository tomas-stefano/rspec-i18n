module RspecI18n
  module Parser
    class NaturalLanguage
      KEYWORDS_LANGUAGE = %w{ name native describe}

      class << self
        def get(language)
          new(language)
        end

        def all
          RspecI18n::SPEC_LANGUAGES.keys.sort.map { |language| get(language) }
        end
      end
      
      def initialize(language)
        @keywords = RspecI18n::SPEC_LANGUAGES[language]
        raise "Language Not Supported" if @keywords.nil?
        @parser = nil
      end

    end
  end
end
