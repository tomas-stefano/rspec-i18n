module Spec
  module Matchers
    class << self
      
      RSPEC_MATCHERS = [:have, :have_at_least, :have_at_most, :have_exactly]
      
      def register_have_matcher
        language = SpecI18n.natural_language        
        RSPEC_MATCHERS.each do |rspec_matcher|
          have_matcher = language.keywords['matchers'][rspec_matcher.to_s]
          have_matcher.split('|').map {|have_value| alias_method have_value, rspec_matcher}
        end
      end
    end
  end
end