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

    gemspec.add_development_dependency('rspec', '>= 1.3.0')
    gemspec.add_development_dependency('cucumber', '>= 0.6.2')
    gemspec.add_development_dependency('terminal-table', '>= 1.4.2')
    gemspec.add_development_dependency('aruba', '>= 0.1.7')
    
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
remove_logs
)

task :spec_all_ruby_versions do
  sh("rvm 1.8.7-p249,1.9.1,1.9.2-preview1 specs")
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

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:rspec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = ['--exclude', "_spec,gems,spec_helper.rb"]
end

require 'spec/rake/verify_rcov'
RCov::VerifyTask.new(:verify_rcov) { |t| t.threshold = 100.0 }

require 'rake/rdoctask'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "doc"
  rdoc.title = "Rspec-I18n"
  rdoc.options << '--line-numbers' << '--inline-source' << '-A cattr_accessor=object'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.rdoc_files.include("Readme.rdoc", "History.rdoc", "lib/**/*.rb")
end
