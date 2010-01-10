require 'spec_helper'

module SpecI18n
  module Matchers
    describe 'register all matcher' do
      
      before(:each) do
        Spec::Runner.configuration.spec_language('pt')
      end
      
      it 'should not raise error for register all the words for i18n' do
        lambda { Spec::Matchers.register_all_matchers }.should_not raise_error
      end
      
    end
  end
end