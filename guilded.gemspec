# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{guilded}
  s.version = "0.2.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["C. Jason Harrelson (midas)"]
  s.date = %q{2009-06-18}
  s.description = %q{Guilded is a framework for building web based components centered around current web standards and best practices. The current  framework is written in ruby, but could be ported to other languages.  Guilded intends to provide a toolset for creating and consuming reusable web components.  Currently, this problem domain is filled with JavaScript frameworks.  These frameworks are wonderful and work very well.   However, they do not degrade gracefully and  are not accessible.  Guilded seeks to provide the same level of "componentization" and ease of use without sacrificing degradability  and accessibility.  Guilded will achieve these goals by applying each technology at our disposal to do what it was intended.    XHTML will be employed for content.  CSS used for layout and styling.  Behavior will be added to a component with JavaScript  through progressive enhancement.  The user will have the best experience with a Guilded component when CSS and JavaScript are  enabled in their browser, but will still be able to use the component when CSS and JavaScript are disabled.   Guilded will use jQuery as it's base JavaScript framework.  jQuery was chosen because it lends itself to progressive enhancement due to the way it was authored.  In addition, the tight integration of jQuery's selectors with CSS selectors is also highly  desirable.  When authoring a Guilded component, it is encouraged to write the behavior code as a jQuery plugin.  This will  allow the jQuery plugin to be used outside of the Guilded project, if desired.  Guilded also seeks to provide a standardized CSS framework for creating layouts that are reusable and predictable.  Guilded will utilize the currently existing RubyGems system to package its components.  A new Guilded component will be packaged  in a Gem and have a dependency on the Guilded gem.  The Guilded gem contains the framework to build Guilded components.}
  s.email = ["jason@lookforwardenterprises.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "guilded.gemspec", "lib/guilded.rb", "lib/guilded/browser_detector.rb", "lib/guilded/component_def.rb", "lib/guilded/exceptions.rb", "lib/guilded/guilder.rb", "lib/guilded/rails.rb", "lib/guilded/rails/active_record/human_attribute_hint.rb", "lib/guilded/rails/active_record/human_attribute_override.rb", "lib/guilded/rails/helpers.rb", "lib/guilded/rails/inactive_record/human_attribute_hint.rb", "lib/guilded/rails/view_helpers.rb", "rails_generators/guilded_assets/guilded_assets_generator.rb", "rails_generators/guilded_assets/templates/guilded.js", "rails_generators/guilded_assets/templates/guilded.min.js", "rails_generators/guilded_assets/templates/jquery-1.2.6.js", "rails_generators/guilded_assets/templates/jquery-1.2.6.min.js", "rails_generators/guilded_assets/templates/jquery-1.3.2.js", "rails_generators/guilded_assets/templates/jquery-1.3.2.min.js", "rails_generators/guilded_assets/templates/jquery-url.js", "rails_generators/guilded_assets/templates/jquery-url.min.js", "rails_generators/guilded_assets/templates/reset-min.css", "rails_generators/guilded_config/guilded_config_generator.rb", "rails_generators/guilded_config/templates/load_guilded_settings.rb", "script/console", "script/destroy", "script/generate", "spec/guilded/component_def_spec.rb", "spec/guilded/guilder_spec.rb", "spec/guilded/rails/helpers_spec.rb", "spec/guilded_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rails.rake", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/midas/guilded/tree/master}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{guilded}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Guilded is a framework for building web based components centered around current web standards and best practices}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
