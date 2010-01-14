module Spec
  module Matchers
    class Be #:nodoc:
      class << self
        def register_be_matcher
          language = SpecI18n.natural_language
          be_matcher = language.keywords['matchers']['be']
          
          # TODO: working with warnings
          return unless be_matcher
      
          be_matcher.split('|').map do |be_value|
            alias_method be_value, :be
          end
        end
      end
    end
  end
end
