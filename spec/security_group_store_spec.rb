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

    it 'saves security groups' do
      sg = SecurityGroup.new('foo')
      @store.save_security_group(sg)

      security_groups = @db.collection('security_groups')
      stored_group = security_groups.find_one
      expect(stored_group['name']).to eq(sg.name)
    end

  end

end
