require 'colored'
require 'core_ext/object/command_line_arguments'

module KernelColors
  def inform(*args)
    puts *args
  end

  { abort: :red, inform: :cyan, warn: :magenta }.each do |method, color|
    original_method = "kernel_#{method}".to_sym
    alias_method original_method, method
    define_method(method) do |*args|
      return __send__ original_method if args.empty?
      __send__ original_method, colorize_arguments(color, *args).join($\)
    end
    private original_method
  end

  private

  def colorize_arguments(color, *args)
    # TODO checking if AutoColor is disabled is not enough since OptionParser may abort prior to that happening
    return args if (respond_to?(:colored) && colored === false) || ARGD.include?('--no-color')
    args.map { |arg| Colored.colorize arg.to_s, foreground: color }
  end
end

Object.send(:include, KernelColors)
