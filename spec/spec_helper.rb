require 'rubygems'
require 'ruby-debug'
require 'spec'
require 'spec-i18n'

$:.unshift(File.dirname(__FILE__), '../lib')

include SpecI18n

def portuguese_language(expected)
  pt = Parser::NaturalLanguage.get("pt")
  SpecI18n.stub!(:natural_language).and_return(pt)
  
  expected['matchers']['be'] = 'ser|estar'
  
  predicade = pt.stub(:keywords).and_return(expected)
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

