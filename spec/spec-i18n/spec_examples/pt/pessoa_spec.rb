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

  def maior_de_idade?
    return true if @idade >= 18
    false
  end

  def pronto_para_votar?
    maior_de_idade?
  end

  def pronto_para_dirigir?
    maior_de_idade?
  end

  def autorizado_a_beber?
    maior_de_idade?
  end
end

# Silly Tests for specifying the library in portuguese language
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

  depois(:suite) do
    @pessoas = []
  end

  exemplo 'deve ser uma instancia da classe Pessoa' do
    @pessoa.deve ser_instancia_de(Pessoa)
  end

  exemplo 'deve incluir uma pessoa' do
    @pessoas.deve incluir(@pessoa)
  end

  exemplo 'deve ser do tipo Pessoa' do
    @pessoa.deve ser_do_tipo(Pessoa)
  end

  exemplo 'deve ter pelo menos uma pessoa' do
    @pessoas.deve ter_no_minimo(1).items
  end

  exemplo 'deve ter exatamente duas pessoas' do
    @pessoas << @pessoa
    @pessoas.deve ter_exatamente(2).items
  end

  exemplo 'deve ter no maximo tres pessoas' do
    @pessoas = []
    @pessoas.deve ter_no_maximo(3).items
  end
  
  contexto "Nome completo" do
    
    antes(:de_cada_exemplo) do
      @pessoa = Pessoa.new("Tomás", "D'Stefano")
    end
  
    exemplo "deve retornar o nome completo" do
      @pessoa.nome_completo.deve ==("Tomás D'Stefano")
    end
    
    exemplo 'nome completo não pode ser nulo' do
      @pessoa.nome_completo.nao_deve ser_igual_a(nil)
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
    assunto { Pessoa.new('Aaron', 'Monkey', :idade => 18) }

    exemplo "deve estar pronto para votar" do
      should estar_pronto_para_votar
    end

    exemplo "deve ser maior de idade" do
      should ser_maior_de_idade
    end

    exemplo "deve estar pronto para dirigir" do
      assunto.deve estar_pronto_para_dirigir
    end

    exemplo "deve estar autorizado para beber(=D)" do
      assunto.deve estar_autorizado_a_beber
    end
  end

  contexto 'menor de idade' do
    assunto { Pessoa.new('Aaron', 'Monkey', :idade => 17) }

    exemplo "nao deve estar pronto para votar" do
      should_not estar_pronto_para_votar
    end

    exemplo "nao deve ser maior de idade" do
      should_not ser_maior_de_idade
    end
  end

end
