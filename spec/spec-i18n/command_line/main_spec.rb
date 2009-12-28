require 'spec_helper'

module SpecI18n
  module CommandLine
    describe Main do
      before(:each) do
        @out = StringIO.new
        @err = StringIO.new
      end
      
      it "should initialize the Main class" do
        @command_line = Main.new(%w{--help}, @out)
        
      end
    end
  end
end