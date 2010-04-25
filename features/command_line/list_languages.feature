Feature: Rspec-i18n all the languages executable 
  
  As an Rspec-i18n user
  I want to run the rspec-i18n executable to see all the languages

	Scenario: See the headers in list languages
	  When I run "rspec-i18n --language help"
	  Then I should see "Language"
	  And I should see "Name"
	  And I should see "Native"
	
	Scenario: See the values of all language
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
		
	  """
	  When I run "rspec-i18n --language help"
	  Then I should see ""
	  