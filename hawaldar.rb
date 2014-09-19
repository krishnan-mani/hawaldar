class Hawaldar

  def initialize(reader, store)
    @reader = reader
    @store = store
  end

  def save_current_security_groups
    current_security_groups = @reader.list_security_groups
    @store.save_security_groups(current_security_groups)
  end

end
