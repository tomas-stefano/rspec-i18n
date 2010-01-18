require 'spec-i18n'

Spec::Runner.configure do |config|
  config.spec_language :pt
end

class Pessoa
  attr_accessor :idade
  def initialize(nome, sobrenome, opcoes={})
    @nome = nome
    @sobrenome = sobrenome
    @idade = opcoes[:idade]
  end
  
  def nome_completo
    "#{@nome} #{@sobrenome}"
  end
end

# Silly Tests
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
      @pessoa.nome_completo.deve ser_igual_a("Tomás D'Stefano")
    end
    
    exemplo 'nome completo não pode ser nulo' do
      @pessoa.nome_completo.nao_deve igual_a(nil)
    end
    
  end

  contexto "a idade" do
    
    antes(:de_todos_exemplos) do
      @pessoa = Pessoa.new("Aaromn", "Monkey", :idade => 20)
    end

    especificar "deve ser opcional" do
      @pessoa.idade.deve ser_igual_a(20)
    end
  end

  contexto 'maior de idade' do
    subject { Pessoa.new('Aaron', 'Monkey', :idade => 18) }

    exemplo "deve estar pronto para votar" do
      deve estar_pronto_para_votar
    end

    exemplo "deve ser maior de idade" do
      deve ser_maior_de_idade
    end
  end

  contexto 'menor de idade' do
    subject { Pessoa.new('Aaron', 'Monkey', :idade => 17) }

    exemplo "nao deve estar pronto para votar" do
      nao_deve estar_pronto_para_votar
    end

    exemplo "nao deve ser maior de idade" do
      nao_deve ser_maior_de_idade
    end
  end
end
