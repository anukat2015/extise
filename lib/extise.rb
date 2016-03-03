module Extise
  MANIFEST = File.expand_path '../extise/META-INF/MANIFEST.MF', __FILE__
  VERSION = File.read(MANIFEST).match(/Bundle-Version:\s*(\d+\.\d+\.\d+)/)[1] || raise
end
