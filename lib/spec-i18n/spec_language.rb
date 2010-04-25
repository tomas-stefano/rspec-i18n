module SpecI18n
  
  # Return the new NaturalLanguage from spec language configuration
  #
  def natural_language
    Parser::NaturalLanguage.new(spec_language)
  end
  
  # Read the configuration language put in the Spec::Runner configure block
  #
  def spec_language
    Spec::Runner.configuration.language
  end
  
  # Return all the languages in languages.yml
  #
  def all_languages
    SpecI18n::SPEC_LANGUAGES
  end
  
  # Return the exaclty value of that keyword
  #
  def grep_value(lang, key)
    SpecI18n::SPEC_LANGUAGES[lang][key]
  end
  
  # List all languages available in the languages.yml
  #
  def list_languages
    languages = all_languages.keys.sort.collect do |lang|
      [ lang, grep_value(lang, 'name'), grep_value(lang, 'native') ]
    end
  end
  
end

include SpecI18n