require 'spec_helper'

module SpecI18n
  module CommandLine
    describe Main do
            
      it "should load the options" do
        options = %w{--version}
        
        Kernel.should_receive(:exit)
        
        STDOUT.should_receive(:puts).and_return(nil)
        
        Main.execute(options)
      end
      
    end
  end
end