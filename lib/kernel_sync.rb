module KernelSync
  @@kernel_sync_mutex = Mutex.new

  %i(abort print puts warn).each do |method|
    original_method = "kernel_unsynced_#{method}".to_sym
    alias_method original_method, method
    define_method(method) do |*args|
      return __send__ original_method if args.empty?
      @@kernel_sync_mutex.synchronize { __send__ original_method, args.join($/) }
    end
    private original_method
  end
end

Object.send(:include, KernelSync)
