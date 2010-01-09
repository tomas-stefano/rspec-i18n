module Spec
  module Matchers
    def method_missing(sym, *args, &block) # :nodoc:

      begin
        language = SpecI18n.natural_language
        be_word = language.keywords['matchers']['be']        
        sym = be_to_english(sym, be_word)
      end
      
      return Matchers::Be.new(sym, *args, &block) if sym.to_s =~ /^be_/
      
      return Matchers::Has.new(sym, *args, &block) if sym.to_s =~ /^have_/
      
      super
    end
    
    # :ser_verdade == :be_verdade
    # :be_true == :be_true
    def be_to_english(sym, be_word)
      be_word = be_word || 'be'
      sym.to_s.gsub(be_word.to_s, 'be').to_sym
    end
  end
end