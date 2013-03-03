require 'spec_helper'

describe "Rtoml" do
  it "parses integers correctly" do
    Rtoml.parse("foo = 42").should == {"foo" => 42}
  end
  
  it "parses multiple keys on multiple lines" do
    string = <<-EOF
    foo = 42
    bar = 100
    EOF
    Rtoml.parse(string).should == {"foo" => 42, "bar" => 100}
  end
end
