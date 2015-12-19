class ActiveRecord::Base
  def self.alias_association(new_name, old_name)
    singleton_class.send :alias_attribute, new_name, old_name
  end

  def self.alias_scope(new_name, old_name)
    singleton_class.send :alias_method, new_name, old_name
  end
end
