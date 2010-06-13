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
  
  Scenario: See the language keywords and translations
    Given I run "rspec-i18n --language pt"
    Then I should see:
    """
    | it                    | isso / isto / especificar / exemplo         |
    """
  
  Scenario: See the all the Matchers of a one language
    When I run "rspec-i18n --language pt"
    Then I should see:
    """
	+-------------------+-------------------------------+
	| Rspec Matchers    | Translated Keyword            |
	+-------------------+-------------------------------+
	| equal             | igual|igual_a                 |
	| eql               | igl                           |
	| have_exactly      | ter_exatamente                |
	| be_a_kind_of      | ser_do_tipo                   |
	| have_at_most      | ter_no_maximo                 |
    """
  
  Scenario: See al the hooks of a one language
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
