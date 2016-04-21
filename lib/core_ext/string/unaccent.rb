class String
  def unaccent
    mb_chars.normalize(:kd).bytes.map { |b| (0x00..0x7F).include?(b) ? b.chr : '' }.join.force_encoding 'ASCII-8BIT'
  end
end
