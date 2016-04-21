class Object
  def instance_variable_get_or_set(name)
    instance_variable_get(name) || instance_variable_set(name, yield)
  end
end
