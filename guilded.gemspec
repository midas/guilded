# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guilded/version"

Gem::Specification.new do |s|
  s.name        = "guilded"
  s.version     = Guilded::VERSION
  s.authors     = ["Jason Harrelson"]
  s.email       = ["jason@lookforwardenterprises.com"]
  s.homepage    = "http://github.com/guilded/guilded"
  s.summary     = %q{A framework for building web based components centered around current web standards and best practices.}
  s.description = %q{Guilded intends to provide a toolset for creating and consuming reusable web components.  Currently, this problem domain is filled with JavaScript frameworks.  These frameworks are wonderful and work very well.   However, they do not degrade gracefully and are not accessible (in most cases).  Guilded seeks to provide the same level of "componentization" and ease of use without sacrificing degradability and accessibility.  Guilded will achieve these goals by applying each technology at our disposal (HTML, CSS and JavaScript) to do as it was intended.}

  s.rubyforge_project = "guilded"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  %w(
    rspec
    shoulda
  ).each do |development_dependency|
    s.add_development_dependency development_dependency
  end

  # s.add_runtime_dependency "rest-client"
end
