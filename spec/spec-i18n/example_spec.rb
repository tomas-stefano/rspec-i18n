require 'spec-i18n'

Spec::Runner.configure do |config|
  config.spec_language :pt
end

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
end