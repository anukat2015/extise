class ActiveRecord::Base
  def self.alias_association(new_name, old_name)
    define_method(new_name) { send old_name }
  end

  def self.alias_scope(new_name, old_name)
    singleton_class.send :alias_method, new_name, old_name
  end

  def self.findable?(object, options = {})
    return true if object.is_a? ActiveRecord::Base
    primary_key_class = options[:primary_key_class] || Integer
    return true if object.is_a? primary_key_class
    return false unless options[:accept_enumerables]
    return true if object.is_a? ActiveRecord::Relation
    return false unless object.is_a? Enumerable
    object.each { |item| return false unless item.is_a?(ActiveRecord::Base) && item.is_a?(primary_key_class) }
    return true
  end
end
