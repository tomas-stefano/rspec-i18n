require 'spec_helper'

module Spec
  module Runner
    describe Configuration do
      with_sandboxed_options do
        with_sandboxed_config do
          describe "#spec_language" do

            it "should default a english language for nil" do
              config.spec_language(nil).should == "en"
            end

            it "should return a pt language" do
              config.spec_language(:pt).should == "pt"
            end

            it "should return a es language using a Symbol" do
              config.spec_language(:es).should == "es"
            end
            
            it "should return a en language for the nil parameter" do
              config.spec_language(nil)
              config.language.should == "en"
            end

            it "should set the portuguese language" do
              config.spec_language(:pt)
              config.language.should == "pt"
            end

            it "should set the espanish language" do
              config.spec_language(:es)
              config.language.should == "es"
            end

          end
          
          describe "load language" do
            before(:each) do
              config.spec_language(:pt)
            end
            it "should load all the modules" do
              config.load_language.should be_true
            end
          end
        end
      end
    end
  end
end
