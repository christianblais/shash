# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require './lib/version'
 
Gem::Specification.new do |s|
  s.name        = "shash"
  s.version     = Utilities::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christian Blais"]
  s.email       = ["christ.blais@gmail.com"]
  s.homepage    = "http://github.com/christianblais/shash"
  s.summary     = "Replace hash keys with method calls"
  s.description = "Replace hash keys with method calls"
 
  s.files = `git ls-files`.split("\n")
  
  s.require_paths = ['lib', 'test']
end
