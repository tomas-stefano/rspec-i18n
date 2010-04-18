module Kernel
  
  # Translate the <b>should</b> and <b>should_not</b> method
  #
  def register_expectations_keywords
    natural_language.expectation_keywords.each do |key, values|
      values.collect { |value| alias_method value, key }
    end
  end
  
end