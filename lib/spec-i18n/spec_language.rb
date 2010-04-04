module SpecI18n
  
  def natural_language
    Parser::NaturalLanguage.get(spec_language)
  end
  
  def spec_language
    Spec::Runner.configuration.language
  end
  
end

include SpecI18n