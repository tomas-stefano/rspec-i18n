module Spec
  module Example
    module Pending
      
      class << self
      
        # Translate the pending word
        #
        def translate_pending_keywords
          natural_language.pending_keywords.each do |pending_method, translated_methods|
            translated_methods.each { |translated_method| alias_method translated_method, pending_method}
          end
        end
      
      end
      
    end
  end
end