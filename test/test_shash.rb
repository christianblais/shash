require File.join(File.dirname(__FILE__), "..", "lib", "shash")

describe Hash do
  it "#to_shash should returns a new Shash object" do
    {"a"=>1}.to_shash.should == Shash.new({"a"=>1})
  end
end

describe Shash do
  it "should accesses hash values through method calls" do
    h = {"a"=>1, "b"=>{"c"=>2}}.to_shash
    h.a.should == 1
    h.b.should == {"c"=>2}.to_shash
    h.b.c.should == 2
  end
  
  it "#method=(value) should set a new key with corresponding value" do
    h = {}.to_shash
    h.y = nil
    h.should == {"y"=>nil}.to_shash
    h.y = {}
    h.should == {"y"=>{}}.to_shash
    h.y.z = 0
    h.should == {"y"=>{"z"=>0}}.to_shash
  end
  
  it "#respond_to? should check for key existence correctly" do
    h = {"a"=>1, "b"=>{"c"=>2}}.to_shash
    h.respond_to?("a").should == true
    h.has_key?("b").should == true
    h.b.key?("c").should == true
  end
end
