require 'cucumber'
require 'cucumber/formatter/pretty'
require 'cucumber/formatter/unicode'
require 'cucumber/cli/language_help_formatter'
  
module SpecI18n
  module CommandLine
    class LanguageHelpFormatter
      
      class << self
        
        # Cucumber print table is loading 
        # because I don't want reiventing the wheel
        #
        def list_languages_and_exit(io)
          raw = Parser::NaturalLanguage.list_languages
          print_table io, raw, :check_lang => false
        end
        
        def list_keywords_and_exit(io, lang)
          language = Parser::NaturalLanguage.get(lang)
          raw = Parser::NaturalLanguage.list_keywords(lang)
          print_table io, raw, :incomplete => language.incomplete?
        end
        
        def print_table(io, raw, options)
          table = Cucumber::Ast::Table.new(raw)
          formatter = Cucumber::Cli::LanguageHelpFormatter.new(nil, io, options)
          Cucumber::Ast::TreeWalker.new(nil, [formatter]).visit_multiline_arg(table)
          Kernel.exit(0)
        end
      end
      
    end
  end
end