module Extric::Aliasing
  def alias_metric(new_name, old_name)
    module_eval "class #{new_name} < #{old_name}; end", __FILE__, __LINE__
  end
end
