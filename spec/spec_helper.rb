require 'yaml'
require 'vcr'

config_file = File.join(File.dirname(__FILE__), 'config.yml')
config = YAML.load(File.read(config_file))
CONFIG_AWS = config[:aws]
CONFIG_STORE = config[:database]

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock
end
