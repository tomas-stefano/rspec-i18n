module RspecI18n
  module Parser
    describe NaturalLanguage do

      before(:each) do
        NaturalLanguage.instance_variable_set(:@languages, nil)
        @pt = NaturalLanguage.get('pt')
      end

      it "should raise for the non existing language" do
        lambda {  NaturalLanguage.new('en') }.should raise_error()
      end
    end
  end
end
