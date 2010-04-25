
Given /^rspec\-i18n read the "([^\"]*)" file$/ do |filename|
  SpecI18n.should_receive(:SPEC_LANGUAGE_FILE).and_return(current_dir + filename)
end