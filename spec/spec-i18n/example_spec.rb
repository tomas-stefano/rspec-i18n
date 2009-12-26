require 'spec-i18n'

Spec::Runner.configure do |config|
  config.spec_language :pt
end

# TODO: Verificar esse carregamento de modulos
include Spec::DSL
Main.register_adverbs
Kernel.register_expectations_keywords

class Pessoa
  def initialize(nome, sobrenome)
    @nome = nome
    @sobrenome = sobrenome
  end
  def nome_completo
    "#{@nome} #{@sobrenome}"
  end
end

# TODO: Verificar o it
descreva Pessoa do
  it "deve retornar o seu nome completo" do
    Pessoa.new("Tomas", "D'Stefano").nome_completo.deve == "Tomas D'Stefano"
  end
end