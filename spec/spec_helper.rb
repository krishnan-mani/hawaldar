require 'yaml'

config_file = File.join(File.dirname(__FILE__), 'config.yml')
config = YAML.load(File.read(config_file))
CONFIG_AWS = config[:aws]
CONFIG_STORE = config[:database]
