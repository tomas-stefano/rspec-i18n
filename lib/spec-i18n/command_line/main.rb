require 'spec-i18n/command_line/options'
require 'spec-i18n/platform'

module SpecI18n
  module CommandLine
    class Main
      def self.execute(args)
        new(args).execute!
      end
      
      def initialize(args, out_stream = STDOUT, error_stream = STDERR)
        @args = args
        @out_stream = out_stream
        @error_stream = error_stream
      end
      
      def execute!
        options = Options.new(@out_stream, @error_stream, @args)
        options.parse!(@args) 
      end
    end
  end
end