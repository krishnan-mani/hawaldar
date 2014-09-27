require_relative 'spec_helper'
require_relative '../lib/security_group_reader'
require 'aws-sdk'
require 'vcr'

# RSpec.configure do |c|
#   c.around(:each) do |example|
#     VCR.use_cassette(example.metadata[:full_description]) do
#       example.run
#     end
#   end
# end


describe SecurityGroupReader do

  def remove_security_groups
    @ec2_client.security_groups.each do |group|
      group.delete unless group.name == 'default'
    end
  end

  before :all do
    @ec2_client = AWS::EC2.new(CONFIG_AWS)

    remove_security_groups
    @reader = SecurityGroupReader.new(CONFIG_AWS)
  end

  after :all do
     remove_security_groups
  end

  describe '#list_security_groups' do

    it 'lists the default security group when no other groups were created' do
      security_groups = @reader.list_security_groups
      expect(security_groups.first['group_name']).to eq('default')
    end

    it 'lists all existing security groups' do
      @ec2_client.security_groups.create('foo')

      security_groups = @reader.list_security_groups
      security_group_names = security_groups.collect do |group|
        group['group_name']
      end
      expect(security_group_names.sort).to eq(['default', 'foo'])
    end

  end

end
