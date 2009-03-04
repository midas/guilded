class GuildedConfigGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file 'load_guilded_settings.rb', 'config/initializers/load_guilded_settings.rb' 
    end
  end
end