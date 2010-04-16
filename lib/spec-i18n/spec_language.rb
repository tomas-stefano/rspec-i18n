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
  
end

include SpecI18n