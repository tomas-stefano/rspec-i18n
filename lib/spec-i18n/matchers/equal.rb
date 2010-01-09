module Spec
  module Matchers
    class << self
      def register_equal_matcher
        language = SpecI18n.natural_language
        equal_matcher = language.keywords['matchers']['equal'].split('|')
        
        equal_question = "#{equal_matcher}?"
        equal_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :equal
          alias_method equal_question, :equal?
        end
      end
    end
  end
end