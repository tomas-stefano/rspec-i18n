module SpecI18n
  def spec_language
    Spec::Runner.configuration.language
  end
end

include SpecI18n