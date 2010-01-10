module Spec
  module Matchers
    class << self
      def register_include_matcher
        language = SpecI18n.natural_language
        include_matcher = language.keywords['matchers']['include']
        
        include_matcher = include_matcher.split('|')
        
        include_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :include
        end
      end
    end
  end
end