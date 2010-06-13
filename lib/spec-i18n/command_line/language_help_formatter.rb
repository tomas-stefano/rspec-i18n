require 'spec-i18n/spec_language'
require 'spec-i18n/parser'

def require_terminal_table
  begin
    require 'terminal-table/import'
  rescue LoadError
    require 'rubygems'
    require 'terminal-table/import'
  end
end

require_terminal_table

module SpecI18n
  module CommandLine
    class Language
      extend SpecI18n::Parser
      class << self
                        
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
          hooks_table(io, language)
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
          true
        end
        
        def hooks_table(io, language)
          hooks = language.hooks_permutation
          return nil if hooks.empty?
          table_for_hooks = table do
            self.headings = ['Rspec Hooks', 'Translated Keyword']
            hooks.each do |rspec_keyword, translated_keyword|
              add_row [rspec_keyword, translated_keyword.join(' / ')]
            end
          end
          print_table io, table_for_hooks
          true
        end
        
      end
      
    end
  end
end
