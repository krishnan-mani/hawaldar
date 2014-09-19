require 'yaml'

config_file = File.join(File.dirname(__FILE__), 'config.yml')
CONFIG = YAML.load(File.read(config_file))
