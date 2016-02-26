module Butcher
  extend self

  def process(items, options = {}, &block)
    batch_size = options[:batch_size] || 1000
    return items.in_batches of: batch_size, &block if items.respond_to? :in_batches
    return items.each_slice batch_size, &block if items.respond_to? :each_slice
    raise ArgumentError
  end
end
