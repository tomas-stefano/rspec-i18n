module SpecI18n
  def spec_language
    Spec::Runner.configuration.language
  end
  def natural_language
    Parser::NaturalLanguage.get(spec_language)
  end
end

include SpecI18n