class ActiveRecord::Base
  def self.alias_association(new_name, old_name)
    define_method(new_name) { send old_name }
  end

  def self.alias_scope(new_name, old_name)
    singleton_class.send :alias_method, new_name, old_name
  end

  def self.findable?(object, options = {})
    return true if object.is_a? ActiveRecord::Base
    primary_key_class = options.fetch :primary_key_class, Integer
    return true if primary_key_class && object.is_a?(primary_key_class)
    return false unless options.fetch :accept_relations, true
    return true if object.is_a? ActiveRecord::Relation
    return false unless object.is_a? Enumerable
    object.each { |item| return false if !item.is_a?(ActiveRecord::Base) && (primary_key_class ? !item.is_a?(primary_key_class) : true) }
    return true
  end
end
