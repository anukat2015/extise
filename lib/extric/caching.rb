module Extric::Caching
  extend ActiveSupport::Concern

  class_methods do
    def cache_method(name, matcher, options = {}, &block)
      size = options.delete(:size) || 16.megabytes
      cached_name, uncached_name, cache_name = name.to_sym, "uncached_#{name}".to_sym, "@#{name}_cache".to_sym
      alias_method uncached_name, cached_name
      define_method cached_name do |*args|
        cache = instance_variable_get cache_name
        cache ||= instance_variable_set cache_name, ActiveSupport::Cache.lookup_store(:memory_store, size: size)
        key = matcher.try(:call, *args) || matcher
        cache.fetch(key, options) { send uncached_name, *args, &block }
      end
    end
  end
end
