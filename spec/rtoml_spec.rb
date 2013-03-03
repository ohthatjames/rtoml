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
  end
end
