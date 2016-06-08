require 'optbind'

module OptionBinder::AutoDescribe
  def option(*opts, &handler)
    if opts.size == 1 && opts[0].is_a?(String) && opts[0] != /\A\s*-/
      default = @reader.call(opts[0].split(/\s+/, 2)[0].to_sym) rescue nil
      opts[0] << " Default #{[default] * ','}" if !default.nil? && (!default.respond_to?(:empty?) || !default.empty?)
    end
    super
  end

  alias_method :opt, :option
end

OptionBinder.prepend OptionBinder::AutoDescribe
