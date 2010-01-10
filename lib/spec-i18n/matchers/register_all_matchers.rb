module Spec
  module Matchers

    def self.register_all_matchers
      Spec::Matchers::Be.register_be_matcher
      register_be_close_matcher
      register_be_an_instance_of_matcher
      register_be_a_kind_of_matcher
      register_eql_matcher
      register_equal_matcher
      register_exist_matcher
      register_have_matcher
      register_include_matcher
      register_match_matcher
      register_raise_error_matcher
      register_satisfy_matcher
    end
    
  end
end