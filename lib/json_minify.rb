require 'strscan'
require 'multi_json'
require "json_minify/version"

module JsonMinify
  def minify(str)
    ss, buf = StringScanner.new(str), ''

    until ss.eos?
      # Remove whitespace
      if s = ss.scan(/\s+/)

      # Scan punctuation
      elsif s = ss.scan(/[{},:\]\[]/)
        buf << s

      # Scan strings
      elsif s = ss.scan(/"(.*?[^\\])?"/)
        buf << s

      # Scan reserved words
      elsif s = ss.scan(/(true|false|null)/)
        buf << s

      # Scan numbers
      elsif s = ss.scan(/-?\d+([.]\d+)?([eE][-+]?[0-9]+)?/)
        buf << s

      # Remove C++ style comments
      elsif s = ss.scan(%r<//>)
        ss.scan_until(/(\r?\n|$)/)

      # Remove C style comments
      elsif s = ss.scan(%r'/[*]')
        ss.scan_until(%r'[*]/') or raise SyntaxError, "Unterminated /*...*/ comment - #{ss.rest}"

      # Anything else is invalid JSON
      else
        raise SyntaxError, "Unable to pre-scan string: #{ss.rest}"
      end
    end
    buf
  end

  def minify_parse(buf)
    MultiJson.load(minify(buf))
  end

  def minify_pretty(buf)
    MultiJson.dump(minify_parse(buf), pretty: true)
  end
end

MultiJson.class_eval do
  extend JsonMinify
end

JsonMinify.class_eval do
  extend self
end
