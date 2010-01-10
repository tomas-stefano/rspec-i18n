module Spec
  module Matchers
    class << self
      def register_satisfy_matcher
        language = SpecI18n.natural_language
        satisfy_matcher = language.keywords['matchers']['satisfy'].split('|')
        satisfy_matcher.map do |value|
          alias_method value, :satisfy
        end
      end
    end
  end
end