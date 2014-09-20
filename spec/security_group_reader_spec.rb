require_relative 'spec_helper'
require_relative '../lib/security_group_reader'
require 'vcr'

RSpec.configure do |c|
  c.around(:each) do |example|
    VCR.use_cassette(example.metadata[:full_description]) do
      example.run
    end
  end
end


describe SecurityGroupReader do

  before :all do
    @reader = SecurityGroupReader.new(CONFIG_AWS)
  end

  describe '#list_security_groups' do

    it 'list security groups' do
      security_groups = @reader.list_security_groups
      expect(security_groups).not_to be_empty
    end

  end

end
