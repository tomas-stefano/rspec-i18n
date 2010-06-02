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
          print_table io, table_for_languages(languages), :exit => true
        end
        
        # Return a table to use with command to list all languages
        #
        def table_for_languages(languages)
          table do
            self.headings = ['Language', 'Name', 'Native']
            languages.each { |language| add_row language }
          end
        end
        
        def list_keywords_and_exit(io, lang)
          language = NaturalLanguage.new(lang)
          keywords_table(io, language)
          matchers_table(io, language)
          Kernel.exit(0)
        end
        
        # Print the table to list all languages or keywords of a language
        #
        def print_table(io, raw, options={})
          io.puts raw
          Kernel.exit(0) if options[:exit]
        end
        
        def keywords_table(io, language)
          table_for_keywords = table do
            self.headings = ['Rspec Keywords', 'Translated Keyword']
            language.basic_keywords.each do |rspec_keyword, translated_keyword|
              add_row [rspec_keyword, translated_keyword.to_s.split('|').join(' / ')]
            end
          end
          print_table io, table_for_keywords
        end
        
        def matchers_table(io, language)
          matchers = language.matchers
          return if matchers.empty?
          table_for_matchers = table do
            self.headings = ['Rspec Matchers', 'Translated Keyword']
            matchers.each do |rspec_keyword, translated_keyword|
              add_row [rspec_keyword, translated_keyword]
            end
          end
          print_table io, table_for_matchers
        end
        
      end
      
    end
  end
end
