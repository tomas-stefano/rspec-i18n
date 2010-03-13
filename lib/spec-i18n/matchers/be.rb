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
      matcher_be_some(:true => true).each do |matcher|
        Spec::Matchers.define matcher do
          match do |actual|
            !!actual
          end
        end
      end
    end
    
    def translate_be_false
      matcher_be_some(:false => true).each do |matcher|
        Spec::Matchers.define matcher do
          match do |actual|
            !actual
          end
        end
      end
    end
    
    def translate_be_nil
      matcher_be_some(:nil => true).each do |matcher|
        Spec::Matchers.define matcher do
          match do |actual|
            actual.nil?
          end
        end
      end
    end
    
    def matcher_be_some(options={})
      option = options.keys.select { |key| options[key] != nil }
      language.word_be(option.to_s).map { |word| word.to_sym}
    end
    
    def language
      SpecI18n.natural_language
    end
  
  end
end