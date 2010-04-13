# coding: UTF-8
require 'rubygems'
require 'spec'
require 'spec-i18n'

$:.unshift(File.dirname(__FILE__), '../lib')

include SpecI18n

def stub_language!(natural_language, keywords)
  language = Parser::NaturalLanguage.new(natural_language)
  mock_natural_language(language)
  stub_keywords!(language, keywords)
  language
end

def mock_natural_language(natural_language)
  Parser::NaturalLanguage.should_receive(:new).at_least(:once).and_return(natural_language)
end

def stub_keywords!(natural_language, keywords)
  natural_language.stub!(:keywords).and_return(keywords)
end

def with_sandboxed_options
  attr_reader :options
  
  before(:each) do
    @original_rspec_options = ::Spec::Runner.options
    ::Spec::Runner.use(@options = ::Spec::Runner::Options.new(StringIO.new, StringIO.new))
  end

  after(:each) do
    ::Spec::Runner.use(@original_rspec_options)
  end
  
  yield
end

def with_sandboxed_config
  attr_reader :config
  
  before(:each) do
    @config = ::Spec::Runner::Configuration.new
    @config.should_receive(:load_language).at_least(:once).and_return(true)
    @original_configuration = ::Spec::Runner.configuration
    spec_configuration = @config
    ::Spec::Runner.instance_eval {@configuration = spec_configuration}
  end
  
  after(:each) do
    original_configuration = @original_configuration
    ::Spec::Runner.instance_eval {@configuration = original_configuration}
    ::Spec::Example::ExampleGroupFactory.reset
  end
  
  yield
end

module Spec
  module Matchers
    def fail_with(message)
      raise_error(Spec::Expectations::ExpectationNotMetError, message)
    end
  end
end

module Spec
  module Example
    class ExampleGroupDouble < ExampleGroup
      ::Spec::Runner.options.remove_example_group self
      def register_example_group(klass)
        #ignore
      end
      def initialize(proxy=nil, &block)
        super(proxy || ExampleProxy.new, &block)
      end
    end
  end
end

# Compatibility with Ruby 1.8 and Ruby 1.9
#
class Array
  def all_to_symbols
    self.collect! { |a| a.to_sym }
  end
  alias :to_symbols :all_to_symbols
end
