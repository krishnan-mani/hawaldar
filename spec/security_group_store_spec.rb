require_relative 'spec_helper'
require_relative '../lib/security_group_reader'
require_relative '../lib/security_group_store'
require 'mongo'
include Mongo


describe SecurityGroupStore do

  before :all do
    hostname = CONFIG_STORE[:hostname]
    port = CONFIG_STORE[:port]
    database_name = CONFIG_STORE[:database_name]
    @db = MongoClient.new(hostname, port).db(database_name)
    
    @store = SecurityGroupStore.new(CONFIG_STORE)
  end

  def clear_security_groups
    security_groups = @db.collection('security_groups')
    security_groups.remove
  end

  before :each do
    clear_security_groups
  end
 
  after :each do
    clear_security_groups
  end

  describe '#save_security_group' do

    context 'save' do
      it 'saves single security group' do
	sg = SecurityGroup.new({:ownerId => 1234, :groupId => 'sg-abcd', :group_name => 'foo'})
	@store.save_security_group(sg)

	security_groups = @db.collection('security_groups')
	stored_group = security_groups.find_one
	expect(stored_group['group_name']).to eq(sg['group_name'])
      end

      it 'does not overwrite if it already exists' do
        sg = SecurityGroup.new({:ownerId => 123456781234, :groupId => 'sg-1234abcd'})
        security_groups = @db.collection('security_groups')
        id = security_groups.insert(sg.to_h)

        sg_id = @store.save_security_group(sg)
        expect(sg_id).to eq(id)
      end

    end

  end

end
