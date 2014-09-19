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
    security_groups = @db.collection('security_groups')
    security_groups.insert(security_group.to_h)
  end

end
