module Spec
  module Matchers
    
    class << self
      def register_eql_matcher
        language = SpecI18n.natural_language
        eql_matcher = language.keywords['matchers']['eql'].split('|')
        
        eql_question = "#{eql_matcher}?"
        eql_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :eql
          alias_method eql_question, :eql?
        end
      end
    end
    
  end
end