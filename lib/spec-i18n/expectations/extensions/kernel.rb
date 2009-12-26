module Kernel
  def register_expectations_keywords
    language = SpecI18n::Parser::NaturalLanguage.get(SpecI18n.spec_language)
    @adverbs = language.expectation_keywords
    @adverbs.each do |key, values|
      values.map { |value| alias_method value, key }
    end
  end
end