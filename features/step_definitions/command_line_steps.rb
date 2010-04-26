
Given /^rspec\-i18n read the "([^\"]*)" file$/ do |filename|
  filename = File.join(current_dir, filename)
  filename
end