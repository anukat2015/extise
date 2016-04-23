module Extisimo::Naming
  AMBIGUOUS_USER_NAME_PATTERN = /\?|eclipse|inbox|info|mail|noreply|project|triaged/i
  AMBIGUOUS_REAL_NAME_PATTERN = /\?|birt-report|emf compare|epp error|inbox|info|missing|project|triaged|\A(bod|jpv|php ui|unused)\z/i

  NAME_SEPARATOR = ' / '
  UNKNOWN_NAME = '?'

  def compose_name(*a)
    a.flatten.map { |n| n || UNKNOWN_NAME } * NAME_SEPARATOR
  end

  def filter_names(*a, p)
    a.flatten.map { |n| n.squish if n && n !~ p }.compact
  end

  def pack_names(*a)
    a.flatten.map { |n| n.unaccent.downcase.gsub(/[^a-z]/i, '') if n }.compact
  end
end
