require 'aruba'

module ArubaOverrides
  def detect_ruby_script(cmd)
    if cmd =~ /^rspec-i18n/
      "ruby -I. -I../../lib -S ../../bin/#{cmd}"
    else
      super(cmd)
    end
  end
end

World(ArubaOverraides)