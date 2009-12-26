require 'spec_helper'

module Spec
  describe Runner do
      
      describe "the right language for the specs" do
        
        before(:each) do
          @language = :pt
        end
        
        it "should assign the spec_language" do
          Spec::Runner.configure do |config|
            config.spec_language @language
          end
          Spec::Runner.configuration.language.should == @language.to_s
        end
      end

  end
end
