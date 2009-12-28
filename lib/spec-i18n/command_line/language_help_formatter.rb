require 'cucumber'
require 'cucumber/formatter/pretty'
require 'cucumber/formatter/unicode'
require 'cucumber/cli/language_help_formatter'
  
module SpecI18n
  module CommandLine
    class LanguageHelpFormatter
      class << self
        
        def list_languages_and_exit(io)
          raw = SpecI18n::Parser::NaturalLanguage.list_languages
          
          # Cucumber print table is loading 
          # because I don't want reiventing the wheel
          table = Cucumber::Ast::Table.new(raw)
          formatter = Cucumber::Cli::LanguageHelpFormatter.new(nil, io, :check_lang => true)
          Cucumber::Ast::TreeWalker.new(nil, [formatter]).visit_multiline_arg(table)
          Kernel.exit(0)
        end
        
      end
    end
  end
end