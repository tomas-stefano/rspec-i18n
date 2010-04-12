require "spec_helper"

module Spec
  module Example
    describe ExampleGroupMethods do
      
      before(:each) do
        @keywords = {"it" => "isto|especificar"}
        stub_language!("pt", @keywords)
        Spec::Example::ExampleGroupMethods.register_example_adverbs
      end
      
      it "should include the example translated methods" do
        example_group = Spec::Example::ExampleGroup
        [:isto, :especificar].each do |example_method|
          example_group.methods.to_symbols.should include(example_method)
        end
      end
      
    end
  end
end