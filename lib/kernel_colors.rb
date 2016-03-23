require 'colored'

module KernelColors
  alias_method :inform, :puts

  alias_method :uncolored_abort, :abort
  alias_method :uncolored_inform, :inform
  alias_method :uncolored_warn, :warn

  def abort(*args)
    uncolored_abort args.map { |arg| arg.to_s.red }
  end

  def inform(*args)
    uncolored_inform args.map { |arg| arg.to_s.cyan }
  end

  def warn(*args)
    uncolored_warn args.map { |arg| arg.to_s.magenta }
  end
end

Kernel.send(:include, KernelColors)
