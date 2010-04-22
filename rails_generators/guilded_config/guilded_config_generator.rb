class GuildedConfigGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file 'guilded_config.rb', 'config/initializers/guilded_config.rb' 
    end
  end
end