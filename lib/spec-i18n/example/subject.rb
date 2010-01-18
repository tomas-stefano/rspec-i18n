module Spec
  module Example
    module Subject
      module ExampleGroupMethods
        class << self
          def register_subjects
            alias_method :assunto, :subject
          end
        end
      end
      module ExampleMethods
        class << self
          def register_subjects
            language = SpecI18n.natural_language
            language.subject_keywords.each do |key, values|
              values.map { |value| alias_method value, key }
            end
          end
        end
      end
    end
  end
end
