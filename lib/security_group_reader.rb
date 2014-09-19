require 'aws-sdk'

class SecurityGroupReader

  def initialize(config)
    AWS.config(config)
    @client = AWS::EC2.new.client
  end

  def list_security_groups
    core_response = @client.describe_security_groups
    core_response.data[:security_group_info].collect do |sg_info|
      SecurityGroup.new(sg_info)
    end
  end

end

class SecurityGroup

  def initialize(security_group_info)
    @sg = security_group_info
  end

  def to_h
    @sg.dup
  end

  def [](key)
    @sg[key.to_sym]
  end

=begin

:security_group_info - (Array)
  :owner_id - (String)
  :group_name - (String)
  :group_id - (String)
  :group_description - (String)
  :ip_permissions - (Array)
    :ip_protocol - (String)
    :from_port - (Integer)
    :to_port - (Integer)
    :groups - (Array)
      :user_id - (String)
      :group_name - (String)
      :group_id - (String)
    :ip_ranges - (Array)
      :cidr_ip - (String)
  :ip_permissions_egress - (Array)
    :ip_protocol - (String)
    :from_port - (Integer)
    :to_port - (Integer)
    :groups - (Array)
      :user_id - (String)
      :group_name - (String)
      :group_id - (String)
    :ip_ranges - (Array)
      :cidr_ip - (String)
  :vpc_id - (String)
  :tag_set - (Array)
    :key - (String)
    :value - (String)

=end

end
