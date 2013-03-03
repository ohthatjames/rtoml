require 'spec_helper'

describe "Rtoml" do
  it "parses multiple keys on multiple lines" do
    string = <<-EOF
    foo = 42
    bar = 100
    EOF
    Rtoml.parse(string).should == {"foo" => 42, "bar" => 100}
  end
  
  it "ignores blank lines" do
    string = <<-EOF
    
    foo = 42
    
    bar = 100
    
    EOF
    Rtoml.parse(string).should == {"foo" => 42, "bar" => 100}
  end
  
  it "evaluates key groups" do
    string = <<-EOF
    [a.b.c]
    d = 42
    e = 43
    EOF
    Rtoml.parse(string).should == { "a" => { "b" => { "c" => { "d" => 42, "e" => 43 } } } }
  end
  
  it "evaluates multiple key groups" do
    string = <<-EOF
    [a.b]
    foo = 42
    [a.c]
    foo = 42
    EOF
    Rtoml.parse(string).should == { "a" => { "b" => { "foo" => 42 }, "c" => { "foo" => 42 } } }
  end
  
  it "ignores comments" do
    string = <<-EOF
    #comment
    [a.b] #comment
    # comment
    c = 1 # comment
    #comment
    
    #comment
    EOF
    Rtoml.parse(string).should == { "a" => { "b" => { "c" => 1 } } }
  end
  
  describe "types" do
    it "parses integers correctly" do
      Rtoml.parse("foo = 42").should == {"foo" => 42}
    end
    
    it "parses floats correctly" do
      Rtoml.parse("foo = 42.99").should == {"foo" => 42.99}
    end
    
    it "parses booleans correctly" do
      Rtoml.parse("foo = true").should == {"foo" => true}
      Rtoml.parse("foo = false").should == {"foo" => false}
    end
    
    it "parses dates correctly" do
      Rtoml.parse("foo = 1979-05-27T07:32:00Z").should == {"foo" => DateTime.parse("1979-05-27T07:32:00Z")}
    end
    
    it "parses strings correctly" do
      Rtoml.parse('foo = "Hi"').should == {"foo" => "Hi"}
    end
    
    it "parses strings that contain integers as strings" do
      Rtoml.parse('foo = "42"').should == {"foo" => "42"}
    end
    
    it "parses strings that contain double-quotes" do
      Rtoml.parse('foo = "OMG what \" about this"').should == {"foo" => %Q{OMG what " about this}}
    end
  end
end
