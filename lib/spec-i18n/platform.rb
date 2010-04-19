require 'yaml'

module SpecI18n
  version            = YAML.load_file(File.dirname(__FILE__) + '/../../VERSION.yml')
  VERSION            = [version[:major], version[:minor], version[:patch]].compact.join(".")
  SPEC_LANGUAGE_FILE = File.expand_path(File.dirname(__FILE__) + '/languages.yml')
  SPEC_LANGUAGES     = YAML.load_file(SPEC_LANGUAGE_FILE)
end
