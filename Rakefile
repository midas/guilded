require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "guilded"
    gem.summary = %Q{A framework for building web based components centered around current web standards and best practices.}
    gem.description = %Q{Guilded intends to provide a toolset for creating and consuming reusable web components.  Currently, this problem domain is filled with JavaScript frameworks.  These frameworks are wonderful and work very well.   However, they do not degrade gracefully and are not accessible.  Guilded seeks to provide the same level of "componentization" and ease of use without sacrificing degradability and accessibility.  Guilded will achieve these goals by applying each technology at our disposal to do what it was intended.}
    gem.email = "jason@lookforwardenterprises.com"
    gem.homepage = "http://github.com/midas/guilded"
    gem.authors = ["C. Jason Harrelson (midas)"]
    gem.add_development_dependency "rspec", ">=1.2.8"
    gem.add_dependency "activesupport", ">= 2.0.2"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   if File.exist?('VERSION')
#     version = File.read('VERSION')
#   else
#     version = ""
#   end
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "test #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

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
