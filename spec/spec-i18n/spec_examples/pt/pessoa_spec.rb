# coding: UTF-8
require File.expand_path(File.join(__FILE__, "../../../../spec_helper"))

Spec::Runner.configure do |config|
  config.spec_language :pt
end

class Pessoa
  attr_accessor :idade, :nome
  def initialize(nome, sobrenome, opcoes={})
    @nome = nome
    @sobrenome = sobrenome
    @idade = opcoes[:idade]
    @filhos = opcoes[:filhos]
  end
  
  def nome
    @nome.downcase.to_sym
  end
  
  def exist?
    true unless self.nil?
  end
  
  def nome_completo
    "#{@nome} #{@sobrenome}"
  end
  
  def informacoes
    return nil if nome_completo.strip.empty?
    nome_completo
  end
  
  def filhos
    @filhos || []
  end
  
  def maior_de_idade?
    return true if @idade >= 18
    false
  end
  
  def menor_de_idade?
    return false if maior_de_idade?
    true 
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

exemplos_distribuidos "Todas Pessoas" do
  isto "deve se comportar como todas pessoas" do
  end
end

distribua_como :TodasPessoas do
  isto "deve se comportar como pessoas normais" do
  end
end

descreva Pessoa do
  deve_se_comportar_como "Todas Pessoas"
  deve_se_comportar_como TodasPessoas
  
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

  isto 'deve ser uma instancia da classe Pessoa' do
    @pessoa.deve ser_instancia_de(Pessoa)
  end
  
  especificar 'deve existir' do
    @pessoa.deve existir
  end

  especificar 'deve incluir uma pessoa' do
    @pessoas.deve incluir(@pessoa)
  end

  especificar 'deve ser do tipo Pessoa' do
    @pessoa.deve ser_do_tipo(Pessoa)
  end
  
  isto 'deve lançar uma excessão' do
    lambda { @pessoa.isso_nao_existe }.deve mostrar_excessao
  end
  
  isto 'deve satisfazer a condicao de maior de idade' do
    @pessoa.deve satisfazer { |pessoa| pessoa == @pessoa}
  end

  isto 'deve ter pelo menos uma pessoa' do
    @pessoas.deve ter_no_minimo(1).items
  end

  isto 'deve ter exatamente duas pessoas' do
    @pessoas << @pessoa
    @pessoas.deve ter_exatamente(2).items
  end

  isto 'deve ter no maximo tres pessoas' do
    @pessoas = []
    @pessoas.deve ter_no_maximo(3).items
  end
  
  contexto "Nome completo" do
    
    antes(:de_cada_exemplo) do
      @pessoa = Pessoa.new("Tomás", "D'Stefano")
    end
  
    isto "deve retornar o nome completo" do
      @pessoa.nome_completo.deve ==("Tomás D'Stefano")
    end
    
    isto 'deve retornar nome completo em simbolo' do
      @pessoa.nome.deve ser_igual_a(:tomás)
    end
    
    isto 'nome completo nao pode ser nulo' do
      @pessoa.nome_completo.nao_deve ser_nulo
    end
    
  end

  contexto "a idade" do
      
    antes(:de_todos_exemplos) do
      @pessoa = Pessoa.new("Aaromn", "Monkey", :idade => 20)
    end

    # Voce tambem pode usar a palavra especificar
    especificar "deve ser opcional" do
      @pessoa.idade.deve ser_igual_a(20)
    end
    
    # Voce tambem pode usar a palavra exemplo
    exemplo "deve retornar verdadeiro se for maior de idade" do
      @pessoa.maior_de_idade?.deve ser_verdadeiro
    end
    
    exemplo "deve retornar falso se for menor de idade" do
      @pessoa.menor_de_idade?.deve ser_falso
    end
    
    exemplo "deve retornar nulo caso nao tenha informacao" do
      Pessoa.new("", "").informacoes.deve ser_nulo
    end
    
    exemplo "deve não ter nenhum filho" do
      @pessoa.filhos.deve ser_vazio
    end
    
  end

  contexto 'maior de idade' do
    assunto { Pessoa.new('Aaron', 'Monkey', :idade => 18) }

    exemplo "deve estar pronto para votar" do
      deve estar_pronto_para_votar
    end
    
    exemplo "deve ser maior de idade" do
      deve ser_maior_de_idade
    end

    exemplo "deve estar pronto para dirigir" do
      assunto.deve estar_pronto_para_dirigir
    end

    exemplo "deve estar autorizado para beber =D" do
      assunto.deve estar_autorizado_a_beber
    end
  end

  contexto 'menor de idade' do
    assunto { Pessoa.new('Aaron', 'Monkey', :idade => 17) }

    exemplo "nao deve estar pronto para votar" do
      nao_deve estar_pronto_para_votar
    end

    exemplo "nao deve ser maior de idade" do
      nao_deve ser_maior_de_idade
    end
    
    exemplo "nao deve estar pronto para votar" do
      assunto.nao_deve estar_pronto_para_votar
    end
    
    exemplo "nao deve estar autorizado para beber =(" do
      assunto.nao_deve estar_autorizado_a_beber
    end
  end

end
