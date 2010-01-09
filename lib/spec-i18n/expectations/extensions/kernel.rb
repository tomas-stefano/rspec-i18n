module Kernel
  def register_expectations_keywords
    language = SpecI18n.natural_language
    @adverbs = language.expectation_keywords
    @adverbs.each do |key, values|
      values.map { |value| alias_method value, key }
    end
  end
end