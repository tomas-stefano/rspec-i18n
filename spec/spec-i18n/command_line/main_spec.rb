require 'spec_helper'

module SpecI18n
  module CommandLine
    describe Main do
      before(:each) do
        @out = StringIO.new
        @err = StringIO.new
      end
      
      it "should load the options" do
        options = %w{--help}
        @command_line = Main.new(options)
        SpecI18n::CommandLine::Options.should_receive(:new).
                  with(STDOUT, STDERR, options).and_return(options)
                  
        @command_line.execute!
      end
      
    end
  end
end