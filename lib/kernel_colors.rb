require 'colored'

module KernelColors
  alias_method :inform, :puts

  { abort: :red, inform: :cyan, warn: :magenta }.each do |method, color|
    original_method = "original_#{method}".to_sym
    alias_method original_method, method
    define_method(method) { |*args| send original_method, colorize_arguments(color, *args).join($\) }
    private original_method
  end

  private

  def colorize_arguments(color, *args)
    return args if respond_to?(:colored) && colored === false
    args.map { |arg| Colored.colorize arg.to_s, foreground: color }
  end
end

Object.send(:include, KernelColors)
