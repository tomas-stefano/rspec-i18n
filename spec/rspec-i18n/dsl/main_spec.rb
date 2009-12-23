require 'spec_helper'

module Spec
  module DSL
    describe DSL do
      before(:each) do
        include Spec::DSL::Main
      end

      ["descreva", "contexto"].each do |method|
        descreva "#{method}" do
          contexto "#{method}" do
          end
        end
      end

    end
  end
end
