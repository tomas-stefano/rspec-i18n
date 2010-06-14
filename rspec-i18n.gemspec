# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec-i18n}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tomas D'Stefano"]
  s.date = %q{2010-06-14}
  s.default_executable = %q{rspec-i18n}
  s.description = %q{A internacionalization tool written in Ruby for the Rspec Framework}
  s.email = %q{tomasdestefi@gmail.com}
  s.executables = ["rspec-i18n"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "Gemfile",
     "History.rdoc",
     "License.txt",
     "README.rdoc",
     "Rakefile",
     "TODO.txt",
     "Tasks",
     "VERSION.yml",
     "bin/rspec-i18n",
     "cucumber.yml",
     "examples/i18n/de/german_spec.rb",
     "examples/i18n/pt/portuguese_spec.rb",
     "features/command_line/list_languages.feature",
     "features/support/env.rb",
     "lib/spec-i18n.rb",
     "lib/spec-i18n/command_line/language_help_formatter.rb",
     "lib/spec-i18n/command_line/main.rb",
     "lib/spec-i18n/command_line/options.rb",
     "lib/spec-i18n/dsl.rb",
     "lib/spec-i18n/dsl/main.rb",
     "lib/spec-i18n/example.rb",
     "lib/spec-i18n/example/before_and_after_hooks.rb",
     "lib/spec-i18n/example/example_group_methods.rb",
     "lib/spec-i18n/example/pending.rb",
     "lib/spec-i18n/example/subject.rb",
     "lib/spec-i18n/expectations.rb",
     "lib/spec-i18n/expectations/extensions.rb",
     "lib/spec-i18n/expectations/extensions/kernel.rb",
     "lib/spec-i18n/languages.yml",
     "lib/spec-i18n/matchers.rb",
     "lib/spec-i18n/matchers/be.rb",
     "lib/spec-i18n/matchers/method_missing.rb",
     "lib/spec-i18n/matchers/register_all_matchers.rb",
     "lib/spec-i18n/matchers/translate_basic_matchers.rb",
     "lib/spec-i18n/parser.rb",
     "lib/spec-i18n/parser/natural_language.rb",
     "lib/spec-i18n/platform.rb",
     "lib/spec-i18n/runner.rb",
     "lib/spec-i18n/runner/configuration.rb",
     "lib/spec-i18n/spec_language.rb",
     "rspec-i18n.gemspec",
     "spec/spec-i18n/command_line/language_help_formatter_spec.rb",
     "spec/spec-i18n/command_line/main_spec.rb",
     "spec/spec-i18n/command_line/options_spec.rb",
     "spec/spec-i18n/dsl/main_spec.rb",
     "spec/spec-i18n/example/before_and_after_hooks_spec.rb",
     "spec/spec-i18n/example/example_group_methods_spec.rb",
     "spec/spec-i18n/example/pending_spec.rb",
     "spec/spec-i18n/example/subject_spec.rb",
     "spec/spec-i18n/expectations/kernel_spec.rb",
     "spec/spec-i18n/matchers/be_close_spec.rb",
     "spec/spec-i18n/matchers/be_instance_of_spec.rb",
     "spec/spec-i18n/matchers/be_kind_of_spec.rb",
     "spec/spec-i18n/matchers/be_spec.rb",
     "spec/spec-i18n/matchers/eql_spec.rb",
     "spec/spec-i18n/matchers/equal_spec.rb",
     "spec/spec-i18n/matchers/exist_spec.rb",
     "spec/spec-i18n/matchers/have_spec.rb",
     "spec/spec-i18n/matchers/include_spec.rb",
     "spec/spec-i18n/matchers/match_spec.rb",
     "spec/spec-i18n/matchers/raise_error_spec.rb",
     "spec/spec-i18n/matchers/register_all_matchers_spec.rb",
     "spec/spec-i18n/matchers/satisfy_spec.rb",
     "spec/spec-i18n/parser/natural_language_spec.rb",
     "spec/spec-i18n/runner/rspec_i18n_language_spec.rb",
     "spec/spec-i18n/runner/rspec_i18n_spec.rb",
     "spec/spec-i18n/spec_examples/pt/pessoa_spec.rb",
     "spec/spec-i18n/spec_language_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/tomas-stefano/rspec-i18n}
  s.post_install_message = %q{
--------------------------------------------------------------------------------
                              U P G R A D I N G 

Thank you for installing rspec-i18n-1.2.1
Please be sure to read http://wiki.github.com/tomas-stefano/rspec-i18n/upgrading
for information about this release.

Remember: 'TDD is a muscle. You have to exercise it.' =) (Brian Liles)

--------------------------------------------------------------------------------
}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{The internacionalization gem for Rspec}
  s.test_files = [
    "spec/spec-i18n/command_line/language_help_formatter_spec.rb",
     "spec/spec-i18n/command_line/main_spec.rb",
     "spec/spec-i18n/command_line/options_spec.rb",
     "spec/spec-i18n/dsl/main_spec.rb",
     "spec/spec-i18n/example/before_and_after_hooks_spec.rb",
     "spec/spec-i18n/example/example_group_methods_spec.rb",
     "spec/spec-i18n/example/pending_spec.rb",
     "spec/spec-i18n/example/subject_spec.rb",
     "spec/spec-i18n/expectations/kernel_spec.rb",
     "spec/spec-i18n/matchers/be_close_spec.rb",
     "spec/spec-i18n/matchers/be_instance_of_spec.rb",
     "spec/spec-i18n/matchers/be_kind_of_spec.rb",
     "spec/spec-i18n/matchers/be_spec.rb",
     "spec/spec-i18n/matchers/eql_spec.rb",
     "spec/spec-i18n/matchers/equal_spec.rb",
     "spec/spec-i18n/matchers/exist_spec.rb",
     "spec/spec-i18n/matchers/have_spec.rb",
     "spec/spec-i18n/matchers/include_spec.rb",
     "spec/spec-i18n/matchers/match_spec.rb",
     "spec/spec-i18n/matchers/raise_error_spec.rb",
     "spec/spec-i18n/matchers/register_all_matchers_spec.rb",
     "spec/spec-i18n/matchers/satisfy_spec.rb",
     "spec/spec-i18n/parser/natural_language_spec.rb",
     "spec/spec-i18n/runner/rspec_i18n_language_spec.rb",
     "spec/spec-i18n/runner/rspec_i18n_spec.rb",
     "spec/spec-i18n/spec_examples/pt/pessoa_spec.rb",
     "spec/spec-i18n/spec_language_spec.rb",
     "spec/spec_helper.rb",
     "examples/i18n/de/german_spec.rb",
     "examples/i18n/pt/portuguese_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_runtime_dependency(%q<terminal-table>, [">= 1.4.2"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_development_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_development_dependency(%q<terminal-table>, [">= 1.4.2"])
      s.add_development_dependency(%q<aruba>, [">= 0.1.7"])
    else
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<terminal-table>, [">= 1.4.2"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<cucumber>, [">= 0.6.2"])
      s.add_dependency(%q<terminal-table>, [">= 1.4.2"])
      s.add_dependency(%q<aruba>, [">= 0.1.7"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<terminal-table>, [">= 1.4.2"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<cucumber>, [">= 0.6.2"])
    s.add_dependency(%q<terminal-table>, [">= 1.4.2"])
    s.add_dependency(%q<aruba>, [">= 0.1.7"])
  end
end

