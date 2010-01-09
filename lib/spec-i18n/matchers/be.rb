module Spec
  module Matchers
    class Be #:nodoc:
      class << self
        def register_be_matcher
          language = SpecI18n.natural_language
          eql_matcher = language.keywords['matchers']['be'].split('|')
          eql_matcher.map { |be_value| alias_method be_value, :be }
        end
      end
    end
  end
end