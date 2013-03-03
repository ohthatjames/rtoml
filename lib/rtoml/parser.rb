require 'treetop'
require 'polyglot'
Treetop.load(File.dirname(__FILE__) + "/toml")

module Rtoml
  class Parser
    def initialize(input)
      @input = input
    end
    
    def parse
      parser = RtomlParser.new
      result = parser.parse(@input)
      # raise result.inspect
      if !result
        puts parser.failure_reason
        puts parser.failure_line
        puts parser.failure_column
      end
      result.content
    end
  end
end
