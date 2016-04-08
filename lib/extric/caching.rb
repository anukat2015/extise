module Extric::Caching
  extend ActiveSupport::Concern

  def cache
    @cache ||= ActiveSupport::Cache.lookup_store :memory_store, size: 16.megabytes
  end

  class_methods do
    def cache_method(name, matcher, options = {}, &block)
      uncached_name = "uncached_#{name}".to_sym
      alias_method uncached_name, name
      define_method name do |*args|
        key = matcher.try(:call, *args) || matcher
        cache.fetch(key, options) { send uncached_name, *args, &block }
      end
    end
  end
end
