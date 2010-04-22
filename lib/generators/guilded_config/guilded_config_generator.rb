require 'rails/generators'

class GuildedConfigGenerator < Rails::Generators::Base
  def self.source_root
    File.join( File.dirname(__FILE__), 'templates' )
  end
  
  def install_config
    copy_file 'guilded_config.rb', 'config/initializers/guilded_config.rb'
  end
end