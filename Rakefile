# encoding: utf-8
require 'rubygems'
require 'rake'
require "./lib/spec-i18n/platform"

$:.unshift(File.dirname(__FILE__) + '/lib')

POST_MESSAGE = <<-POST_INSTALL_MESSAGE

#{ '-' * 80}
                              U P G R A D I N G 

Thank you for installing rspec-i18n-#{SpecI18n::VERSION}
Please be sure to read http://wiki.github.com/tomas-stefano/rspec-i18n/upgrading
for information about this release.

Remember: 'TDD is a muscle. You have to exercise it.' =) (Brian Liles)

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

    gemspec.add_dependency('rspec', '>= 1.3.0')
    gemspec.add_dependency('terminal-table', '>= 1.4.2')
    gemspec.add_dependency('term-ansicolor', '1.0.4')

    gemspec.add_development_dependency('rspec', '>= 1.2.9')
    gemspec.add_development_dependency('terminal-table', '>= 1.4.2')
    gemspec.add_development_dependency('term-ansicolor', '1.0.4')
    
    gemspec.post_install_message = POST_MESSAGE
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts("-" * 80)
  puts "Jeweler not available. Install it with:
  [sudo] gem install jeweler"
  puts("-" * 80)
end

INTEGRATION_TASKS = %w(
spec_all_ruby_versions
rcov
verify_rcov
git:push
)

task :spec_all_ruby_versions do
  sh("rvm 1.8.6,1.8.7,1.9.1,1.9.2 specs")
  puts
end

namespace :git do
  task :push do
    `git push origin master`
  end
end

task :integrate do
  INTEGRATION_TASKS.each do |integrate_task|
    puts("-" * 80)
    Rake::Task[integrate_task].invoke
  end
end

# I don't wanna use the Spec::Rake::SpecTask
#
task :spec do
 sh('spec spec --diff --color')
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = ['--exclude', "_spec,gems"]
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov) { |t| t.threshold = 100.0 }

