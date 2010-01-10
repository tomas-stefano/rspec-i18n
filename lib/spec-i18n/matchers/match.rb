module Spec
  module Matchers
    class << self
      def register_match_matcher
        language = SpecI18n.natural_language
        match_matcher = language.keywords['matchers']['match']
        
        include_matcher = match_matcher.split('|')
        
        include_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :match
        end
      end
    end
  end
end