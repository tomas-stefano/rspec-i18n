module Spec
  module Runner
    class Configuration
      def spec_language(language)
        if language
          @spec_language = language.to_s
        else
          @spec_language =  "en"
        end
      end

      def language
        @spec_language
      end
    end
    
    class UndefinedLanguageError < StandardError
    end
    
  end
end
