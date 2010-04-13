module Spec
  module Example
    module ExampleGroupMethods
      
        def self.register_example_adverbs
          natural_language.example_group_keywords.each do |key, values|
            values.each { |value|  alias_method value, key }
          end
        end
        
        def self.translate_it_should_behave_like
          natural_language.it_should_behave_like_keywords.each do |it_should_behave_like_method, it_should_behave_like_keywords|
            it_should_behave_like_keywords.each { |keyword| alias_method keyword, it_should_behave_like_method}
          end
        end
        
    end
  end
end