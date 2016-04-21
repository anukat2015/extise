class String
  def ascii
    return self if self.ascii_only?

    self.utf8.normalize(:kd).bytes.map { |b| (0x00..0x7F).include?(b) ? b.chr : '' }.join
  end

  alias_method :utf8, :mb_chars
end
