require 'spec_helper'

include Spec::Example

describe Pending do
  
  describe 'in portuguese for example' do
    
    before(:each) do
      @keywords = { "pending" => 'pendente|pendencia'}
      stub_language!('pt', @keywords)
    end

    it "should have the translate pending method" do
      Pending.translate_pending_keywords
      name_methods = methods.to_symbols
      [:pendente, :pendencia].each do |translated_pending_method|
        name_methods.should include(translated_pending_method)
      end
    end
    
  end
  
  describe 'in spanish for example' do
    
    before(:each) do
      @keywords = { "pending" => 'spec_pendente|pendenciaa'}
      stub_language!('es', @keywords)
    end

    it "should have the translate pending method" do
      Pending.translate_pending_keywords
      name_methods = methods.to_symbols
      [:spec_pendente, :pendenciaa].each do |translated_pending_method|
        name_methods.should include(translated_pending_method)
      end
    end
    
  end
  
end