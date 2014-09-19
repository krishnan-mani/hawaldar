require_relative 'spec_helper'
require_relative '../hawaldar'

describe Hawaldar do

  describe '#save_current_security_groups' do

    it 'queries AWS for the security groups currently in force and persists these' do
      groups = [ {:group_name => 'foo'} ]
      reader = double("reader")
      expect(reader).to receive(:list_security_groups).and_return(groups)

      store = double("store")
      expect(store).to receive(:save_security_groups).with(groups)

      hawaldar = Hawaldar.new(reader, store)
      hawaldar.save_current_security_groups
    end

  end

end
