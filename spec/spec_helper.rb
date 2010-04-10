# coding: UTF-8
require 'rubygems'
require 'spec'
require 'spec-i18n'

$:.unshift(File.dirname(__FILE__), '../lib')

include SpecI18n

def portuguese_language(expected)
  pt = Parser::NaturalLanguage.get("pt")
  SpecI18n.stub!(:natural_language).and_return(pt)
  
  expected['matchers']['be'] = 'ser|estar' unless expected['matchers'].nil?
  
  predicade = pt.stub(:keywords).and_return(expected)
  expected
end

def spanish_language(expected)
  es = Parser::NaturalLanguage.get("es")
  SpecI18n.stub!(:natural_language).and_return(es)
  
  expected['matchers']['be'] = 'ser|estar' unless expected['matchers'].nil?
  
  predicade = es.stub(:keywords).and_return(expected)
  expected
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
end
