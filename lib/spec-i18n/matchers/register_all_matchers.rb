module Spec
  module Matchers

    def self.register_all_matchers
      Spec::Matchers::Be.register_be_matcher
      ["true", "false", "nil"].each do |matcher|
        class_eval <<-BE_WORD
          translate_be_#{matcher}
        BE_WORD
      end
      translate_basic_matchers
    end
    
  end
end