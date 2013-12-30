# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ios_dev_tools/version.rb"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

task :package => [:test] do |t|
  `rm -f ios_dev_tools-*.gem`
  `gem build ios_dev_tools.gemspec`
end

task :publish => [:package] do |t|

  is_wc_clean=`git status`.include?("nothing to commit, working directory clean")

  if not is_wc_clean
    puts "\nERROR: Refusing to publish.\nWorking copy contains changes. Commit the changes or stash them.\n\n"
    return false
  end

  # Publish to rubygems.org and tag the repo
  `gem push ios_dev_tools-#{IOSDevTools::VERSION}.gem && git tag --force --message="Release version: #{IOSDevTools::VERSION}" v_#{IOSDevTools::VERSION}`
end

desc "Run tests"
task :default => :test