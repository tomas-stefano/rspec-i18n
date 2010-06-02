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
	