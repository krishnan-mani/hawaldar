require 'mongo'
include Mongo

class SecurityGroupStore

  def initialize(config)
    hostname = config[:hostname]
    port = config[:port]
    database_name = config[:database_name]
    @db = MongoClient.new(hostname, port).db(database_name)
  end

  def save_security_group(security_group)
    ownerId = security_group[:ownerId]
    groupId = security_group[:groupId]
    find_query = { "ownerId" => ownerId, "groupId" => groupId }

    security_groups = @db.collection('security_groups')
    saved = security_groups.find_one(find_query)
    saved_id = saved ? saved["_id"] : nil

    doc = saved_id ? security_group.to_h.merge!(:_id => saved_id) : security_group.to_h
    security_groups.save(doc)
  end

  def save_security_groups(ary_security_groups)
    Hash[ ary_security_groups.collect do |group|
     [ group, save_security_group(group) ] 
    end ]
  end

end
