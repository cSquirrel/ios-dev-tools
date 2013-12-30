Gem::Specification.new do |s|
  s.name        = 'ios_dev_tools'
  s.version     = '0.1.0'
  s.date        = '2013-12-28'
  s.summary     = "iOS Dev Tools"
  s.description = "Set of ruby wrappers around iOS dev tasks"
  s.authors     = ["Marcin Maciukiewicz"]
  s.email       = 'mm@csquirrel.com'
  s.executables << 'ios_sign'
  s.rubyforge_project = "nowarning"
  s.files       = ["lib/ios_dev_tools.rb", "lib/ios_dev_tools/application_bundle.rb", "lib/ios_dev_tools/provisioning_profile.rb"]
  s.require_paths = ["lib"]
  s.homepage    =
      'https://github.com/cSquirrel/ios_dev_tools'
  s.license       = 'MIT'
end