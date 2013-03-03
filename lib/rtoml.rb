require "rtoml/version"
require 'rtoml/parser'

module Rtoml
  def self.parse(input)
    Parser.new(input).parse
  end
end
