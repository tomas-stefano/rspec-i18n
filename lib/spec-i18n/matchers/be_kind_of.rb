module Spec
  module Matchers
    class << self
      def register_be_a_kind_of_matcher
        language = SpecI18n.natural_language
        be_a_kind_of_matcher = language.keywords['matchers']['be_a_kind_of']
        be_a_kind_of_matcher = be_a_kind_of_matcher.split('|')
        
        be_a_kind_of_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :be_a_kind_of
        end
      end
    end
  end
end