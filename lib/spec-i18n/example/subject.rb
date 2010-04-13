module Spec
  module Example
    module Subject
      module ExampleGroupMethods
        # TODO: Removing Duplications
        class << self
          def register_subjects
            subject_and_its_keywords = natural_language.subject_keywords.merge(natural_language.its_keywords)
            subject_and_its_keywords.each do |key, values|
              values.map { |value| alias_method value, key }
            end
          end
        end
      end
      module ExampleMethods
        class << self
          def register_subjects
            subject_and_expectation_keywords = natural_language.subject_keywords.merge(natural_language.expectation_keywords)
            subject_and_expectation_keywords.each do |key, values|
              values.map { |value| alias_method value, key }
            end
          end
        end
      end
    end
  end
end
