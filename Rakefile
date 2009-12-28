# encoding: utf-8
require 'rubygems'
require 'rake'
require File.join("lib", "spec-i18n", "platform")

$:.unshift(File.dirname(__FILE__) + '/lib')

POST_MESSAGE = <<-POST_INSTALL_MESSAGE

#{ '-' * 80}
                              U P G R A D I N G 

Thank you for installing rspec-i18n-#{SpecI18n::VERSION}
Please be sure to read http://wiki.github.com/tomas-stefano/rspec-i18n/upgrading
for important information about this release.

Remember: 'TDD is a muscle. You have to exercise it.' =) (Brian Liles - The true author of the phrase)

#{ '-' * 80}
POST_INSTALL_MESSAGE

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "rspec-i18n"
    gemspec.summary = "The internacionalization gem for Rspec"
    gemspec.description = "A internacionalization tool written in Ruby for the Rspec Framework"
    gemspec.email = "tomasdestefi@gmail.com"
    gemspec.homepage = "http://github.com/tomas-stefano/rspec-i18n"
    gemspec.authors = ["Tomas D'Stefano"]

    gemspec.add_dependency('rspec', '>= 1.2.9')
    gemspec.add_dependency('cucumber', '>= 0.5.3')

    gemspec.add_development_dependency('rspec', '>= 1.2.9')
    gemspec.add_development_dependency('cucumber', '>= 0.5.3')
    
    gemspec.post_install_message = POST_MESSAGE
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts("-" * 80)
  puts "Jeweler not available. Install it with:
  [sudo] gem install jeweler"
  puts("-" * 80)
end
