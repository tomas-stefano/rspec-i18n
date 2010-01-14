module Spec
  module Matchers

    def self.register_all_matchers
      Spec::Matchers::Be.register_be_matcher
      translate_basic_matchers
    end
    
  end
end