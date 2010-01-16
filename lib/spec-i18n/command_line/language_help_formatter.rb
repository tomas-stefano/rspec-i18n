require 'cucumber'
require 'cucumber/formatter/pretty'
require 'cucumber/formatter/unicode'
require 'cucumber/cli/language_help_formatter'
require 'spec-i18n/parser'
  
module SpecI18n
  module CommandLine
    class LanguageHelpFormatter
      
      class << self
        include SpecI18n::Parser
        
        # Cucumber print table is loading 
        # because I don't want reiventing the wheel
        #
        def list_languages_and_exit(io)
          raw = NaturalLanguage.list_languages
          print_table io, raw, :check_lang => false, :exit => true
        end
        
        def list_keywords_and_exit(io, lang)
          language = NaturalLanguage.get(lang)
          raw = NaturalLanguage.list_basic_keywords(lang)
          raw_two = NaturalLanguage.list_advanced_keywords(lang)

          

          print_table io, raw, :incomplete => language.incomplete?
          print_table io, raw_two, :incomplete => language.incomplete?, :exit => true
        end
        
        def print_table(io, raw, options)
          Kernel.exit(0) if options[:exit]
        end
      end
      
    end
  end
end