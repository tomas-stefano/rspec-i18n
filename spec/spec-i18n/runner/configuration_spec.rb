require 'spec_helper'

module Spec
  module Runner
    describe Configuration do
      with_sandboxed_options do
        with_sandboxed_config do
          describe "#spec_language" do
            it "should default to nil" do
              config.spec_language.should be_nil
            end
            it "should return a pt language" do
              config.spec_language(:pt).should == "pt"
            end
            it "should return a es language using a Symbol" do
              config.spec_language(:es).should == "es"
            end
          end
        end
      end
    end
  end
end
