module Extric::Caching
  extend ActiveSupport::Concern

  class_methods do
    def cache_method(name, store: nil, size: nil, key: nil, options: nil, &block)
      store, size = "#{store || :memory}_store".to_sym, size || 16.megabytes
      cached_name, uncached_name, cache_name = name.to_sym, "uncached_#{name}".to_sym, "@#{name}_cache".to_sym
      visibility = method_visibility cached_name
      alias_method uncached_name, cached_name
      define_method cached_name do |*args|
        cache = instance_variable_get_or_set(cache_name) { ActiveSupport::Cache.lookup_store store, size: size }
        cache.fetch(key.try(:call, *args) || key, options || {}) { send uncached_name, *args, &block }
      end
      send visibility, cached_name
    end
  end
end
