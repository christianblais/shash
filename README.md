Shash
=====
Shash provides quick way to handle configuration file, settings or other form of key/value store. It's based
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
Here his the simpliest scenario
	Settings = Shash.new({"name"=>"Shash!", "application"=>{"version"=>1}})
	Settings.name #=> "Shash!"
	Settings.application #=> {"version"=>1}
	Settings.application.version #=> 1

From a hash, it could not be simplier
	Settings = {"name"=>"Shash!"}.to_shash
	Settings.name #=> "Shash!"

You can of course set values directly from a Shash object
	Settings = Shash.new
	Settings.respond_to?("name") #=> false
	Settings.name = "Shash!"
	Settings.respond_to?("name") #=> true
	Settings.name #=> "Shash!"

From a YAML file, or any other key/value kind of file
	Settings = YAML.load_file( "path/to/your/file.yml" ).to_shash
