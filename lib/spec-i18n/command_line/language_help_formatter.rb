require 'spec-i18n/spec_language'
require 'spec-i18n/parser'
require 'rubygems'
require 'term/ansicolor'
require 'terminal-table/import'
  
module SpecI18n
  module CommandLine
    class Language
      
      class << self
        
        include SpecI18n::Parser
        include Term::ANSIColor
                
        # List Name and Native Keywords of all the languages in the
        # languages.yml
        #
        def list_languages_and_exit(io)
          languages = list_languages
          languages_table = table_for_languages(languages)
          print_table io, languages_table, :exit => true
        end
        
        def list_keywords_and_exit(io, lang)
          keywords = list_keywords(lang)
          print_table io, keywords, :exit => true
        end
        
        def list_keywords(lang)
          language = NaturalLanguage.new(lang)
          table_for_keywords(language)
        end
        
        # Print the table to list all languages or keywords of a language
        #
        def print_table(io, raw, options={})
          io.puts raw
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
        
        def table_for_keywords(language)
          table do
            self.headings = ['Rspec Keywords', 'Translated Keyword']
            language.basic_keywords.each do |rspec_keyword, translated_keyword|
              add_row [rspec_keyword, translated_keyword.to_s.split('|').join(' / ')]
            end
          end
        end
        
      end
      
    end
  end
end
