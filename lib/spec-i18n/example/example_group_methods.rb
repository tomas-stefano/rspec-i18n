module Spec
  module Example
    module ExampleGroupMethods
      
        def self.register_example_adverbs
          natural_language.example_group_keywords.each do |key, values|
            values.each { |value|  alias_method value, key }
          end
        end
        
    end
  end
end