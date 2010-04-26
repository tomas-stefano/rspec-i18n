require 'aruba'
require 'spec/mocks'

module ArubaOverrides
  def detect_ruby_script(cmd)
    if cmd =~ /^rspec-i18n/
      "ruby -S ../../bin/#{cmd}"
    else
      super(cmd)
    end
  end
end

World(ArubaOverrides)

module SpecI18n
end

Before do
  $rspec_mocks ||= Spec::Mocks::Space.new
end

After do
  begin
    $rspec_mocks.verify_all
  ensure
    $rspec_mocks.reset_all
  end  
end
