require 'rubygems'
require 'spec'
require 'spec-i18n'

Spec::Runner.configure do |config|
  config.spec_language :pt
end

class Pessoa
  attr_reader :idade
  def initialize(nome, sobrenome, idade=0)
    @nome = nome
    @sobrenome = sobrenome
    @idade = idade
  end
  
  def nome_completo
    "#{@nome} #{@sobrenome}"
  end
end

descreva Pessoa do
  
  antes(:de_todos) do
    @pessoa = Pessoa.new("Homer", "Simpson")
  end
  
  antes(:de_cada) do
    @pessoas = [@pessoa]
  end
  
  depois(:de_todos) do
    @outras_pessoas = @pessoas.dup
  end
  
  depois(:de_cada) do
    @outras_pessoas = []
  end
  
  contexto "Nome completo" do
    
    antes(:de_cada_exemplo) do
      @pessoa = Pessoa.new("Tomás", "D'Stefano")
    end
  
    exemplo "deve retornar o nome completo" do
      @pessoa.nome_completo.deve == "Tomás D'Stefano"
    end
    
    exemplo 'nome completo não pode ser nulo' do
      @pessoa.nome_completo.nao_deve be_nil
    end
    
  end

  contexto "a idade" do
    
    antes(:de_todos_exemplos) do
      @pessoa = Pessoa.new("Aaromn", "Monkey", 20)
    end

    especificar "deve ser opcional" do
      @pessoa.idade.deve == 20
    end
  end
  
end