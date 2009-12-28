require 'cucumber/formatter/color_io'

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
    end
  end
end