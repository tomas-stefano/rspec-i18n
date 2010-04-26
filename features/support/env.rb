require 'aruba'

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
