require 'spec/matchers/dsl'

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
  
    def translate_be_true

    end
              
    def matcher_be_true
      language = SpecI18n.natural_language
      be_true_matcher = language.keywords['matchers']['be_true']
      be_true_matcher.to_sym
    end
  
  end
end
