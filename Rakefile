require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "riot-mongoid"
    gem.summary = %Q{Riot assertions for Mongoid}
    gem.description = %Q{A collection of assertion macros for testing Mongoid with Riot}
    gem.email = "gabriel.gironda@gmail.com"
    gem.homepage = "http://github.com/gabrielg/riot-mongoid"
    gem.authors = ["gabrielg"]
    gem.add_development_dependency "riot", ">= 0"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_dependency "mongoid", ">=1.2.7"
    gem.add_dependency "riot",    ">=0.10.12"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
