require 'active_support/core_ext/hash/compact'

module Jarun
  attr_accessor :binary

  attr_accessor :init_heap_size, :max_heap_size
  attr_accessor :init_perm_size, :max_perm_size

  def command(*args)
    "java#{options.map { |k, v| " -#{k}#{v}" }.join} -jar #{binary} #{args * ' '}"
  end

  def call(*args)
    `#{command args}`
  end

  private

  def options
    {
      'Xms': init_heap_size,
      'Xmx': max_heap_size,
      'XX:PermSize=': init_perm_size,
      'XX:MaxPermSize=': max_perm_size
    }.compact
  end
end
