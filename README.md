Shash
=====
Shash provides a quick way to handle configuration file, settings or other form of key/value store. It's based
on a single hash, but lets you set/read keys like attributes. Shash stands for StructHash or, for intimates,
SuperHash.

Installation
------------
    gem install shash

Test
----
    rspec test/test_shash.rb

Usage
-----
Here is the simpliest scenario

    Settings = Shash.new({"name"=>"Shash!", "application"=>{"version"=>1}})
    Settings.name #=> "Shash!"
    Settings.application #=> {"version"=>1}
    Settings.application.version #=> 1

From a hash, it could not be simplier

    Settings = {"name"=>"Shash!"}.to_shash
    Settings.name #=> "Shash!"
    Settings[:name] #=> "Shash!"

You can of course set values directly from a Shash object

    Settings = Shash.new
    Settings.has_key?(:name) #=> false
    Settings.name = "Shash!"
    Settings.has_key?(:name) #=> true
    Settings.name #=> "Shash!"

Shash can also deals with arrays

    h = {:a => 1, :b => [{:ba => 1, :bb => 2}, [{:ccc => 3}]]}.to_shash
    h.a #=> 1
    h.b #=> [{:ba => 1, :bb => 2}, [{:ccc => 3}]]
    h.b[0] #=> {:ba => 1, :bb => 2}
    h.b[1][0].ccc #=> 3
    h.b.last.first.ccc #=> 3

From a YAML file, or any other key/value kind of file

    Settings = YAML::load( File.open("path/to/your/file.yml") ).to_shash
