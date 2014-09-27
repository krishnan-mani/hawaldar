require_relative 'spec_helper'
require_relative '../hawaldar'

describe Hawaldar do

  describe '#save_current_security_groups' do

    it 'reads security groups in AWS and persists them locally' do
      groups = [ {:group_name => 'foo'} ]
      reader = double("reader")
      expect(reader).to receive(:list_security_groups).and_return(groups)

      store = double("store")
      expect(store).to receive(:save_security_groups).with(groups)

      hawaldar = Hawaldar.new(reader, store)
      hawaldar.save_current_security_groups
    end

  end

  ## AWS interface:
  # ----------------
  # authorize-security-group-egress (ae)
  # authorize-security-group-ingress (ai)
  # create-security-group (c)
  # delete-security-group (del)
  # describe-security-groups (desc)
  # revoke-security-group-egress (re)
  # revoke-security-group-ingress (ri)

  ## hawaldar interface:
  # ---------------------
  # The hawaldar interface subsumes the AWS interface and extends it
  # hawaldar mimics the mechanism available to configure the use of the AWS CLI and AWS SDKs

  # record security groups (locally) (s)
  # log security group changes
  # report security group changes (r)
  # tag security groups (t)
  # browse security groups (p)
  # search ingress and egress by protocol, port, ip, and security group name (g)
  # search ingress and egress rules in-force and historically (g)
  # respect the isolation of security groups by account

end
