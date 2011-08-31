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
  
  it "#has_key? should check for key existence correctly" do
    h = {"a"=>1, "b"=>{"c"=>2}}.to_shash
    h.has_key?("z").should == false
    h.has_key?("b").should == true
    h.b.has_key?("c").should == true
  end
  
  it "#[] should still works as expected" do
    h = {"a"=>1}.to_shash
    h.a.should == 1
    h["a"].should == 1
  end
  
  it "#[]= should still works as expected" do
    h = Shash.new
    h["b"] = 2
    h.b.should == 2
  end
  
end
