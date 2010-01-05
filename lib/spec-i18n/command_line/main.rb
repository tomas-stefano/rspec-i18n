require 'cucumber/formatter/color_io'
require 'spec-i18n/command_line/options'

module SpecI18n
  module CommandLine
    class Main
      def self.execute(args)
        new(args).execute!
      end
      
      def initialize(args, out_stream = STDOUT, error_stream = STDERR)
        @args = args
        if SpecI18n::WINDOWS
          @out_stream   = out_stream == STDOUT ? Formatter::ColorIO.new(Kernel, STDOUT) : out_stream
        else
          @out_stream = out_stream
        end
        @error_stream = error_stream
      end
      
      def execute!
        options = Options.new(@out_stream, @error_stream, @args)
        options.parse!(@args) 
      end
    end
  end
end