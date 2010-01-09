module Spec
  module Matchers
    class << self
      def register_exist_matcher
        language = SpecI18n.natural_language
        exist_matcher = language.keywords['matchers']['exist'].split('|')
        
        exist_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :exist
        end
      end
    end
  end
end