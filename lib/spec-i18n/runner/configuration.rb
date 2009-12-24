module Spec
  module Runner
    class Configuration
      def spec_language(language=nil)
        return nil unless language
        @spec_language = language.to_s
      end
    end
  end
end
