module Spec
  module Runner
    class Configuration
      def spec_language(language)
        @spec_language = language ? language.to_s : "en"
        load_language
        @spec_language
      end

      def language
        @spec_language
      end
      
      # Load all Modules and Classes for the language specified
      def load_language
        language = SpecI18n.natural_language
        Kernel.warn("Incomplete Keywords For The Language") if language.incomplete?
        Spec::DSL::Main.register_adverbs
        Kernel.register_expectations_keywords
        Spec::Example::ExampleGroupMethods.register_example_adverbs
        Spec::Example::BeforeAndAfterHooks.register_hooks
        Spec::Matchers.register_all_matchers
        Spec::Example::Subject::ExampleGroupMethods.register_subjects
        Spec::Example::Subject::ExampleMethods.register_subjects
      end
    end
    
    class UndefinedLanguageError < StandardError
    end
    
  end
end
