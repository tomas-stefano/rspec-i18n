require "spec_helper"

module Spec
  module Example
    describe ExampleGroupMethods do
      
      context 'when it keywords' do
        before(:each) do
          @keywords = {"it" => "isto|especificar"}
          stub_language!("pt", @keywords)
          Spec::Example::ExampleGroupMethods.register_example_adverbs
        end

        it "should include the example translated methods" do
          example_group_methods = Spec::Example::ExampleGroup.methods.to_symbols
          [:isto, :especificar].each do |example_method|
            example_group_methods.should include(example_method)
          end
        end
      end
      
      context 'when it should behave like keywords' do
        before(:each) do
          @keywords = { 'it_should_behave_like' => 'deve_se_comportar_como|deve_se_comportar'}
          stub_language!('pt', @keywords)
          Spec::Example::ExampleGroupMethods.translate_it_should_behave_like
        end
        
        it 'should include the it should behave like method translated' do
          example_group_methods = Spec::ExampleGroup.methods.to_symbols
          [:deve_se_comportar_como, :deve_se_comportar].each do |translated_method|
            example_group_methods.should include(translated_method)
          end
        end
        
      end
      
    end
  end
end