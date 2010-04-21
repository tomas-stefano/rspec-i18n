require 'spec/matchers/dsl'

module Spec
  module Matchers
    
    class << self
      
      def translate_be_matcher
        natural_language.keywords_of_be_word.collect { |be_value| alias_method be_value, :be }
      end
      
      def translate_be_true
        matcher_be_some(:true => true).each do |matcher|
          Spec::Matchers.define(matcher) do
            match do |actual|
              !!actual
            end
          end
        end
      end
        
      def translate_be_false
        matcher_be_some(:false => true).each do |matcher|
          Spec::Matchers.define(matcher) do
            match do |actual|
              !actual
            end
          end
        end
      end
        
      def translate_be_nil
        matcher_be_some(:nil => true).each do |matcher|
          Spec::Matchers.define(matcher) do
            match do |actual|
              actual.nil?
            end
          end
        end
      end
        
      def translate_be_empty
        matcher_be_some(:empty => true).each do |matcher|
          Spec::Matchers.define(matcher) do
            match do |actual|
              actual.empty?
            end
          end
        end
      end
        
      def matcher_be_some(options={})
        option = options.keys.select { |key| options[key] != nil }
        natural_language.word_be(option.join).map { |word| word.to_sym}
      end
      
    end
  
  end
end