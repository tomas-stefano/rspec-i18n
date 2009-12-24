require 'spec_helper'
include Spec::DSL

describe Main do
  before(:each) do
    include Spec::DSL::Main
    Main.register_adverbs
  end

  describe 'a linguagem específica de dominio internacionalizada' do

    context "manipulação dos métodos da DSL do Rspec" do

      RspecI18n::Parser::NaturalLanguage.get("pt").dsl_keywords.each do |keyword|
        it "deve possuir o método #{keyword} da dsl na lingua corrente" do
          Main.methods.should be_include(keyword)
        end
      end

      RspecI18n::Parser::NaturalLanguage.get("es").dsl_keywords.each do |keyword|
        it "deve possuir o método #{keyword} da dsl na linguagem corrente" do
          pending
          Main.methods.should be_include(keyword)
        end
      end

    end
  end

end
