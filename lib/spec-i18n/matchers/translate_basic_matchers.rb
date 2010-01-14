module Spec
  module Matchers
    class << self
      
      RSPEC_MATCHERS = [ :be_close, :be_an_instance_of, :be_a_kind_of,
                         :eql, :equal, :exist, :have, :have_at_least, 
                         :have_at_most, :have_exactly, :include, :match, 
                         :raise_error, :satisfy ]
      
      def translate_basic_matchers
        language = SpecI18n.natural_language        
        RSPEC_MATCHERS.each do |rspec_matcher|
          matcher = language.keywords['matchers'][rspec_matcher.to_s]

          return true if matcher.nil?

          matcher.split('|').map do |matcher_value| 
            alias_method matcher_value, rspec_matcher
          end
        end
      end
    end
  end
end