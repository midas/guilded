require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "guilded"
    gem.summary = %Q{A framework for building web based components centered around current web standards and best practices.}
    gem.description = %Q{Guilded intends to provide a toolset for creating and consuming reusable web components.  Currently, this problem domain is filled with JavaScript frameworks.  These frameworks are wonderful and work very well.   However, they do not degrade gracefully and are not accessible.  Guilded seeks to provide the same level of "componentization" and ease of use without sacrificing degradability and accessibility.  Guilded will achieve these goals by applying each technology at our disposal (HTML, CSS and JavaScript) to do as it was intended.}
    gem.email = "jason@lookforwardenterprises.com"
    gem.homepage = "http://github.com/midas/guilded"
    gem.authors = ["C. Jason Harrelson (midas)"]
    gem.add_development_dependency "shoulda", ">= 2.10.2"
    gem.add_dependency "activesupport", ">= 2.0.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
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

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "tester #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
