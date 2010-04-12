module Spec
  module Matchers
    class << self
      
      RSPEC_MATCHERS = [:be_close, :be_an_instance_of, :be_a_kind_of,
                        :eql, :equal, :exist, :have, :have_at_least, 
                        :have_at_most, :have_exactly, :include, :match, 
                        :raise_error, :satisfy ]
      
      MATCHERS_WITH_QUESTIONS = [ :eql, :equal ]
      
      # Translate all the basic matcher for the Natural Language
      #
      def translate_basic_matchers
        RSPEC_MATCHERS.each do |rspec_matcher|
          matcher = natural_language.find_matcher(rspec_matcher)
          translate_matcher(matcher, rspec_matcher)
        end
      end
      
      # Translate a matcher from a rspec_matcher
      #
      # Example: 
      #   pt:
      #     matchers:
      #       be_close: estar_proximo
      #       equal: igual
      #
      #  rspec_matcher = :be_close  ->  matcher = { "be_close" => ['estar_proximo']}
      #
      #  rspec_matcher = :equal     ->  matcher = { "equal"    => ['igual']}
      #
      #  and so on ...
      #
      def translate_matcher(matcher, rspec_matcher)
        matcher[rspec_matcher.to_s].collect do |matcher_value|
          translate_matcher_with_question(matcher_value, rspec_matcher)
          alias_method matcher_value, rspec_matcher
        end
      end
      
      # Translate a method with the '?'
      #
      #
      def translate_matcher_with_question(matcher_value, rspec_matcher)
        Object.class_eval do
          alias_method "#{matcher_value}?", "#{rspec_matcher}?" if MATCHERS_WITH_QUESTIONS.include?(rspec_matcher)
        end
      end
      
    end
    
  end
end