module Butcher
  extend self

  def process(items, options = {}, &block)
    batch_size = options[:batch_size] || 1000
    index, block_with_hooks = 0, -> (batch) do
      options[:before_batch].call batch, index if options[:before_batch]
      results = block.call batch
      options[:after_batch].call batch, index, results if options[:after_batch]
      index += 1
      results
    end
    return items.in_batches of: batch_size, &block_with_hooks if items.respond_to? :in_batches
    return items.each_slice batch_size, &block_with_hooks if items.respond_to? :each_slice
    raise ArgumentError
  end
end
