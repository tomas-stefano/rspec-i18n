Feature: Rspec-i18n all the languages executable 
  In order to read the translated keywords
  As an Rspec-i18n user
  I want to run the rspec-i18n executable to see all the languages

  Scenario: See the headers in list languages
    When I run "rspec-i18n -l help"
    Then I should see "Language"
    And I should see "Name"
    And I should see "Native"
  
  Scenario: See the values of all language
    When I run "rspec-i18n -l help"
    Then I should see "German"
    And I should see "Deutsch"
    And I should see "Portuguese"
	And I should see "Korean"
  
  Scenario: See the language keywords and translations in ruby 1.8.7-p249
	Given I am using rvm "1.8.7-p249"
    When I run "rspec-i18n --language pt"
    Then I should see:
    """
    +-----------------------+---------------------------------------------+
	| Rspec Keywords        | Translated Keyword                          |
	+-----------------------+---------------------------------------------+
	| after                 | depois                                      |
	| before                | antes                                       |
	| describe              | descreva / contexto                         |
	| it                    | isso / isto / especificar / exemplo         |
	| it_should_behave_like | deve_se_comportar_como                      |
	| its                   | exemplo_do_assunto                          |
	| name                  | Portuguese                                  |
	| native                | Português                                  |
	| pending               | pendente                                    |
	| share_as              | distribua_como                              |
	| shared_examples_for   | exemplos_distribuidos / exemplo_distribuido |
	| should                | deve                                        |
	| should_not            | nao_deve                                    |
	| subject               | assunto                                     |
	+-----------------------+---------------------------------------------+
    """
  
  Scenario: See the language keywords and translations in ruby 1.9.1
	Given I am using rvm "1.9.1"
    When I run "rspec-i18n --language pt"
    Then I should see:
    """
    +-----------------------+---------------------------------------------+
	| Rspec Keywords        | Translated Keyword                          |
	+-----------------------+---------------------------------------------+
	| after                 | depois                                      |
	| before                | antes                                       |
	| describe              | descreva / contexto                         |
	| it                    | isso / isto / especificar / exemplo         |
	| it_should_behave_like | deve_se_comportar_como                      |
	| its                   | exemplo_do_assunto                          |
	| name                  | Portuguese                                  |
	| native                | Português                                   |
	| pending               | pendente                                    |
	| share_as              | distribua_como                              |
	| shared_examples_for   | exemplos_distribuidos / exemplo_distribuido |
	| should                | deve                                        |
	| should_not            | nao_deve                                    |
	| subject               | assunto                                     |
	+-----------------------+---------------------------------------------+
    """

  Scenario: See the all the Matchers of a one language
    When I run "rspec-i18n --language pt"
    Then I should see:
    """
	+-------------------+---------------------------------+
	| Rspec Matchers    | Translated Keyword              |
	+-------------------+---------------------------------+
	| be                | ser / estar                     |
	| be_a_kind_of      | ser_do_tipo                     |
	| be_an_instance_of | ser_instancia_de                |
	| be_close          | estar_perto / estar_proximo     |
	| empty_word        | vazio                           |
	| eql               | igl                             |
	| equal             | igual / igual_a                 |
	| exist             | existir                         |
	| false_word        | falso                           |
	| have              | ter                             |
	| have_at_least     | ter_no_minimo                   |
	| have_at_most      | ter_no_maximo                   |
	| have_exactly      | ter_exatamente                  |
	| include           | incluir                         |
	| match             | corresponder                    |
	| nil_word          | nulo                            |
	| raise_error       | mostrar_erro / mostrar_excessao |
	| satisfy           | satisfazer                      |
	| true_word         | verdadeiro                      |
	+-------------------+---------------------------------+
    """
  
  Scenario: See al the hooks of a one language
	Given I am using rvm "1.8.7-p249"
    When I run "rspec-i18n --language pt"
    Then I should see:
    """
	+----------------+------------------------------------------------+
	| Rspec Hooks    | Translated Keyword                             |
	+----------------+------------------------------------------------+
	| before(:all)   | antes(:de_todos) / antes(:de_todos_exemplos)   |
	| after(:all)    | depois(:de_todos) / depois(:de_todos_exemplos) |
	| before(:each)  | antes(:de_cada) / antes(:de_cada_exemplo)      |
	| after(:each)   | depois(:de_cada) / depois(:de_cada_exemplo)    |
	| before(:suite) | antes(:suite)                                  |
	| after(:suite)  | depois(:suite)                                 |
	+----------------+------------------------------------------------+
    """
