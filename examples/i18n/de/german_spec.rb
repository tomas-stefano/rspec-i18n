# coding: UTF-8
require 'lib/spec-i18n'

Spec::Runner.configure do |config|
  config.spec_language :de
end

class Person
end

#  PLEASE - Replace with GOOD EXAMPLES
#
beschreibe Person do
  
  vorher(:von_jeder) do
    @vorher = 'Before Keyword!'
  end
  
  es 'wahr sollte wahr sein' do
    true.sollte wahr_sein
  end
  
  es 'falsch sollte falsch sein' do
    false.sollte falsch_sein
  end
  
  es '@vorher sollte nicht null sein' do
    @vorher.sollte_nicht null_sein
  end
  
  es 'leer sollte leer sein' do
    [].sollte leer_sein
  end
  
  es 'nicht leer sollte nicht leer sein' do
    [1].sollte_nicht leer_sein
  end
  
end