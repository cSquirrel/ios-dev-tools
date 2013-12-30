# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ios_dev_tools.rb"

Gem::Specification.new do |s|

  s.name        = 'ios_dev_tools'
  s.version     = IOSDevTools::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date        = '2013-12-28'
  s.summary     = "iOS Dev Tools"
  s.description = "Set of ruby wrappers around iOS dev tasks"
  s.authors     = ["Marcin Maciukiewicz"]
  s.email       = 'mm@csquirrel.com'
  s.homepage    = 'https://github.com/cSquirrel/ios-dev-tools'
  s.license     = 'MIT'
  s.rubyforge_project = "nowarning"

  s.files       = `git ls-files -- lib/*`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end