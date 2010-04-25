require 'term/ansicolor'
require 'terminal-table/import'
require 'spec-i18n/spec_language'
require 'spec-i18n/parser'
  
module SpecI18n
  module CommandLine
    class Language
      
      class << self
        
        include SpecI18n::Parser
        include Term::ANSIColor
        
        String.class_eval do
          include Term::ANSIColor
        end
        
        # List Name and Native Keywords of all the languages in the
        # languages.yml
        #
        def list_languages_and_exit(io)
          languages = list_languages
          languages_table = table_for_languages(languages)
          print_table io, languages_table, :exit => true
        end
        
        def list_keywords_and_exit(io, lang)
          
        end
        
        # Print the table to list all languages or keywords of a language
        #
        def print_table(io, raw, options={})
         io.puts raw.to_s.send(options[:color] || :green).bold
         Kernel.exit(0) if options[:exit]
        end
        
        # Return a table to use with command to list all languages
        #
        def table_for_languages(languages)
          table do
            self.headings = ['Language', 'Name', 'Native']
            languages.each { |language| add_row language }
          end
        end
        
      end
      
    end
  end
end
