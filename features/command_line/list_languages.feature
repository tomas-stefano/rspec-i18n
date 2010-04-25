Feature: Rspec-i18n all the languages executable 
  
  As an Rspec-i18n user
  I want to run the rspec-i18n executable to see all the languages

  Background:
	Given a file named "languages.yml" with:
	  """
  de:
    name: German
    native: Deutsch
  
  es:
    name: Spanish
    native: Español
  
  pt:
    name: Portuguese
    native: Português

  ja:
    name: Japanese
    native: 
		
	  """
	And rspec-i18n read the "languages.yml" file

	Scenario: See the headers in list languages
	  When I run "rspec-i18n -l help"
	  Then I should see "Language"
	  And I should see "Name"
	  And I should see "Native"
	
	Scenario: See the values of all language
	  When I run "rspec-i18n -l help"
	  Then I should see "German"
	  And I should see "Deutsch"
	  And I should see "Japanese"