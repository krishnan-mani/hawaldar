require_relative 'spec_helper'
require_relative '../lib/security_group_reader'


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
