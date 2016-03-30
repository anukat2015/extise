require 'active_support'

require 'dyna'
require 'extisimo'
require 'extric/version'

module Extric
  module Concepts
    extend ActiveSupport::Autoload
  end

  module Elements
    extend ActiveSupport::Autoload

    autoload :CyclomaticComplexity
    autoload :LinesOfCodeCombination
    autoload :RecentLinesOfCode
  end

  module Sessions
    extend ActiveSupport::Autoload

    autoload :LinesOfCodeCombination
    autoload :RecentLinesOfCode
  end

  def self.resolve_metric!(file: nil, library: nil)
    _, name, type, handle = Dyna.resolve_and_create! file: file, library: library
    target = File.basename(File.dirname file).singularize
    target = handle.target.to_s if handle.respond_to? :target
    name = handle.name.to_s if handle.respond_to? :name
    raise "invalid target at #{file}" unless Metric::TARGETS.include? target
    raise "invalid handle at #{file}" unless handle.respond_to? :measure
    return target, name, file, type, handle
  end

  def self.message(metric, user, subject, content = $!)
    message = "#{metric.class} #{content.respond_to?(:message) ? content.message : (content || '?').to_s}"
    message << " on #{subject.class}:#{subject.id} for #{user.class}:#{user.id}"
  end

  module Reporting
    def message(user, subject, content = $!)
      Extric.message self, user, subject, content
    end
  end
end
