module Spec
  module Matchers
    
    # Method Missing that returns Predicate for the respective sym word
    # Search the translate be word in the languages.yml for the rspec-i18n try 
    # to comunicate with the Rspec
    #
    def method_missing(sym, *args, &block) # :nodoc:\
      matchers = natural_language.keywords['matchers']
      be_word = matchers['be'] if matchers
      sym = be_to_english(sym, be_word)
      return Matchers::BePredicate.new(sym, *args, &block) if be_predicate?(sym)
      return Matchers::Has.new(sym, *args, &block) if have_predicate?(sym)      
      super
    end
    
    # Return something true(equivalent) for Be Predicate
    #
    def be_predicate?(sym)
      sym.to_s =~ /^be_/
    end
    
    # Return something true(equivalent) for Have predicate
    #
    def have_predicate?(sym)
      sym.to_s =~ /^have_/
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
