module Spec
  module Matchers
    def method_missing(sym, *args, &block) # :nodoc:

      language = SpecI18n.natural_language
      be_word = language.keywords['matchers']['be']      
      sym = be_to_english(sym, be_word)
      
      return Matchers::BePredicate.new(sym, *args, &block) if sym.to_s =~ /^be_/
      return Matchers::Has.new(sym, *args, &block) if sym.to_s =~ /^have_/
      
      super
    end
    
    # Transform the word in be for rspec work properly
    #
    # be_to_english(:ser_feliz, :ser)        # => :be_feliz
    # be_to_english(:estar_incluso, :estar)  # => :be_incluso
    # be_to_english(:ser_feliz, 'ser|estar') # => :be_feliz
    #
    def be_to_english(sym, be_word)
      be_word = be_word || 'be'
      
      sym.to_s.gsub(/#{be_word}/, 'be').to_sym
    end
  end
end
