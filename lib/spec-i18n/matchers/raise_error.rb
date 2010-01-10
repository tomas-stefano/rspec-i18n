module Spec
  module Matchers
    class << self
      def register_raise_error_matcher
        language = SpecI18n.natural_language
        raise_error_matcher = language.keywords['matchers']['raise_error'].split('|')
        raise_error_matcher.map do |value|
          alias_method value, :raise_error
        end
      end
    end
  end
end