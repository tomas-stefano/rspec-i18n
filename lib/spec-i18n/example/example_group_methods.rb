module Spec
  module Example
    module ExampleGroupMethods
      
        def self.register_example_adverbs
          language = SpecI18n.natural_language
          @adverbs = language.example_group_keywords
          @adverbs.each do |key, values|
            values.map do |value|
              alias_method value, key
            end
          end
        end
        
    end
  end
end