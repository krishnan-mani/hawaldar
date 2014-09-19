require 'aws-sdk'

class SecurityGroupReader

  def initialize(config)
    AWS.config(config)
    @client = AWS::EC2.new.client
  end

  def list_security_groups
    core_response = @client.describe_security_groups
    core_response.data
  end

end
