module Spec
  module Matchers
    class << self
      def register_be_close_matcher
        language = SpecI18n.natural_language
        be_close_matcher = language.keywords['matchers']['be_close'].split('|')
        
        be_close_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :be_close
        end
      end
    end
  end
end