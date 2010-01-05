require 'spec_helper'

module SpecI18n
  module CommandLine
    describe Options do
      describe 'parsing' do
        
        before(:each) do
          @output_stream ||= StringIO.new
          @error_stream ||= StringIO.new
        end
        
        def options 
          @options ||= Options.new(@output_stream, @error_stream)          
        end
        
        def when_parsing(args)
          yield
          options.parse!(args.is_a?(Array) ? args : args.split(' '))
        end
        
        context "--language" do
          context "with LANG especified as help" do
            
            it "should list all know languages" do
              when_parsing "--language help" do
                require 'spec-i18n/command_line/language_help_formatter'
                LanguageHelpFormatter.should_receive(:list_languages_and_exit).with(@output_stream)
              end
            end
            
            it "should list all know keywords for the language" do
              when_parsing "--language pt" do
                require 'spec-i18n/command_line/language_help_formatter'
                LanguageHelpFormatter.should_receive(:list_keywords_and_exit).with(@output_stream, "pt")
              end
            end
            
            it "exits the program" do
              when_parsing('--language help') { Kernel.should_receive(:exit) }
            end
            
          end
        end
      end
    
    end
  end
end