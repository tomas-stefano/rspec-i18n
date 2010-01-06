require 'spec-i18n/command_line/language_help_formatter'

module SpecI18n
  module CommandLine
    class Options
      
      def initialize(output_stream = STDOUT, error_stream = STDERR, options = {})
        @output_stream = output_stream
        @error_stream = error_stream
        @options = options
      end
      
      def parse!(args)
        @args = args
        @args.extend(::OptionParser::Arguable)
        @args.options do |opts|
          opts.banner = [ "Usage: rspec-i18n [options] [LANGUAGE]", "", "Examples:",
            "rspec-i18n --language help", "rspec-i18n --language pt"].join("\n")            
          opts.on("-l LANGUAGE", "--language LANGUAGE", "List keywords for a particular language",
            %{Run with "--language help" to see all languages}) do |language|
            print_languages(language)
          end
          opts.on_tail("-v", "--version", "Show version.") do
            print_and_exit(SpecI18n::VERSION)
          end
          opts.on_tail("-h", "--help", "You're looking at it.") do
            print_and_exit(opts.help)
          end
        end.parse!
        self
      end
      
      def print_languages(language)
        if language == 'help'
          LanguageHelpFormatter.list_languages_and_exit(@output_stream)
        else
          LanguageHelpFormatter.list_keywords_and_exit(@output_stream, language)
        end
      end
      
      def print_and_exit(message)
        @output_stream.puts message
        Kernel.exit(0)
      end
    end
  end
end