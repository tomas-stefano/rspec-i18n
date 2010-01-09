module Spec
  module Matchers
    class << self
      def register_be_an_instance_of_matcher
        language = SpecI18n.natural_language
        be_an_instance_of_matcher = language.keywords['matchers']['be_an_instance_of']
        
        be_an_instance_of_matcher = be_an_instance_of_matcher.split('|')
        
        be_an_instance_of_matcher.map do |value_matcher| 
          alias_method value_matcher.to_sym, :be_an_instance_of
        end
      end
    end
  end
end