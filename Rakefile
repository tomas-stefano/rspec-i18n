# encoding: utf-8
require 'rubygems'
require 'rake'

$:.unshift(File.dirname(__FILE__) + '/lib')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rspec-i18n"
    gemspec.summary = "The internacionalization gem for Rspec"
    gemspec.description = "A internacionalization tool written n Ruby"
    gemspec.email = "tomasdestefi@gmail.com"
    gemspec.homepage = "http://github.com/tomas-stefano/rspec-i18n"
    gemspec.authors = ["Tomas D'Stefano"]

    gem.add_dependency 'rspec', '>= 1.2.9'

    gem.add_development_dependency 'rspec', '>= 1.2.9'

    Jeweler::GemcutterTasks.new
  end
rescue LoadError
  puts "Jeweler not available. Install it with:
  [sudo] gem install jeweler" 
end
