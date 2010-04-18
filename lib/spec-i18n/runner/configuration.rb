module Spec
  module Runner
    class Configuration
      
      attr_reader :rspec_language
      
      # Method to put in the Spec::Runner configure block and translated all the
      # Rspec methods
      #
      # Spec::Runner.configure do |config|
      #   config.spec_language :es
      #   ...
      # end
      #
      def spec_language(language_for_translated)
        @rspec_language = language_for_translated ? language_for_translated.to_s : raise(UndefinedLanguageError, 'Language #{language_for_translated.class}')
        load_language
        rspec_language
      end

      # Return the current language in configure block
      #
      def language
        rspec_language
      end
      
      # Translate all the keywords for the language specified
      #
      def load_language
        natural_language = SpecI18n.natural_language
        warning_messages_for_incomplete_languages!(natural_language)
        load_dsl_keywords
        load_expectation_keywords
        load_example_keywords
        load_hooks_keywords
        load_all_matchers
        load_subject_keywords
        load_shared_examples_keywords
      end
      
      # Return a Warning for incomplete language
      # Nil if natural_language is complete
      #
      def warning_messages_for_incomplete_languages!(natural_language)
        if natural_language.incomplete?
          message = "\n Language Warning: Incomplete Keywords For The Language '#{language}' \n"
          Kernel.warn(message)
        end
      end
      
      def load_dsl_keywords
        Spec::DSL::Main.register_adverbs       
      end
      
      def load_expectation_keywords
        Kernel.register_expectations_keywords
      end
      
      def load_example_keywords
        Spec::Example::ExampleGroupMethods.register_example_adverbs
        Spec::Example::Pending.translate_pending_keywords
      end
      
      def load_hooks_keywords
        Spec::Example::BeforeAndAfterHooks.register_hooks
      end
      
      def load_all_matchers
        Spec::Matchers.register_all_matchers
      end
      
      def load_subject_keywords
        Spec::Example::Subject::ExampleGroupMethods.register_subjects
        Spec::Example::Subject::ExampleMethods.register_subjects
      end
      
      def load_shared_examples_keywords
        Spec::DSL::Main.translate_shared_examples_for
        Spec::DSL::Main.translate_share_as_keywords
        Spec::Example::ExampleGroupMethods.translate_it_should_behave_like
      end
      
    end
    
    class UndefinedLanguageError < StandardError
    end
    
  end
end
